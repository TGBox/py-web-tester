"""
Execution Controller QThread for py-web-tester PySide6 GUI.
Runs Robot Framework test suites asynchronously without blocking the UI.
Integrates real-time log capturing, progress updates, speed control (Maximal 0ms, 2x Speed, Normal, Slow-Mo, Manual),
step-by-step manual stepping, and execution benchmark timing comparisons (Original recorded duration vs Automated run time).
"""

import sys
import io
import os
from pathlib import Path
from typing import List, Dict, Any
from PySide6.QtCore import QThread, Signal, Slot
import robot

from libraries.step_listener import execution_state, StepListener

class StdoutRedirector:
    def __init__(self, callback):
        self.callback = callback

    def write(self, text):
        if text:
            self.callback(text)

    def flush(self):
        pass

class ExecutionControllerThread(QThread):
    progress_signal = Signal(int, str)      # step_count, current_keyword
    log_signal = Signal(str)               # log text
    step_waiting_signal = Signal(int, str)  # step_count, keyword
    finished_signal = Signal(bool, str)     # success, summary message

    def __init__(
        self,
        test_file_paths: List[str],
        headless: bool = True,
        speed_mode: str = "NORMAL",  # "MAX", "2X", "NORMAL", "SLOWMO", "MANUAL"
        slowmo_ms: int = 500
    ):
        super().__init__()
        self.test_file_paths = test_file_paths
        self.headless = headless
        self.speed_mode = speed_mode
        self.slowmo_ms = slowmo_ms
        self.routine_benchmarks: List[Dict[str, Any]] = []

    def _get_action_delay_ms(self) -> int:
        if self.speed_mode == "MAX":
            return 0
        elif self.speed_mode == "2X":
            return 20
        elif self.speed_mode == "NORMAL":
            return 50
        elif self.speed_mode == "SLOWMO":
            return self.slowmo_ms
        elif self.speed_mode == "MANUAL":
            return 0
        return 50

    def run(self):
        delay_ms = self._get_action_delay_ms()
        manual_mode = (self.speed_mode == "MANUAL")

        # Configure global execution state
        execution_state.reset()
        execution_state.set_slowmo(delay_ms)
        execution_state.set_manual_mode(manual_mode)
        execution_state.callback = self._listener_callback
        self.routine_benchmarks.clear()

        output_dir = Path("results").resolve()
        output_dir.mkdir(parents=True, exist_ok=True)

        # Build Robot Framework Arguments
        robot_args = [
            "--outputdir", str(output_dir),
            "--pythonpath", os.getcwd(),
            "--listener", "libraries.step_listener.StepListener",
            "--variable", f"HEADLESS:{'TRUE' if self.headless else 'FALSE'}",
            "--variable", f"ACTION_DELAY:{delay_ms}ms",
            "--loglevel", "INFO"
        ] + self.test_file_paths

        mode_name = {
            "MAX": "Maximal (Sofort wenn bereit)",
            "2X": "Doppelte Geschwindigkeit (2x)",
            "NORMAL": "Normal",
            "SLOWMO": f"Slow-Mo ({delay_ms}ms)",
            "MANUAL": "Manuell (Schritt-für-Schritt)"
        }.get(self.speed_mode, self.speed_mode)

        self.log_signal.emit(f"=== Starte Testausführung ({'Headless' if self.headless else 'Sichtbarer Browser (Headed)'}, Modus: {mode_name}) ===")
        if not self.headless:
            self.log_signal.emit("➜ Visueller Mauszeiger & Keystroke-HUD am unteren Bildschirmrand sind AKTIVIERT.")
        self.log_signal.emit(f"Dateien: {', '.join([Path(p).name for p in self.test_file_paths])}\n")

        # Redirect stdout/stderr to GUI log signal
        orig_stdout = sys.stdout
        orig_stderr = sys.stderr
        redirector = StdoutRedirector(lambda line: self.log_signal.emit(line))

        exit_code = -1
        try:
            sys.stdout = redirector
            sys.stderr = redirector

            exit_code = robot.run_cli(robot_args, exit=False)
        except Exception as e:
            self.log_signal.emit(f"\n[FEHLER] Testausführung fehlgeschlagen: {e}\n")
        finally:
            sys.stdout = orig_stdout
            sys.stderr = orig_stderr
            execution_state.reset()

        # Emit Benchmark comparison summary to log if benchmarks were recorded
        if self.routine_benchmarks:
            self.log_signal.emit("\n================================================================================")
            self.log_signal.emit("📊 ROUTINEN-LAUFZEIT & BENCHMARK-VERGLEICH")
            self.log_signal.emit("--------------------------------------------------------------------------------")
            for bm in self.routine_benchmarks:
                rname = bm["routine_name"]
                st = bm["exec_stats"]
                rec_s = st["recorded_duration_ms"] / 1000.0
                auto_s = st["auto_duration_ms"] / 1000.0
                factor = st["speedup_factor"]
                savings = st["savings_pct"]
                self.log_signal.emit(f"• Routine '{rname}':")
                self.log_signal.emit(f"  - Originale Aufnahme (Manuelle Interaktion) : {rec_s:.2f} s")
                self.log_signal.emit(f"  - Automatisierte Test-Ausführung          : {auto_s:.2f} s")
                self.log_signal.emit(f"  - Vergleich & Zeitersparnis                : {factor}x schneller (+{savings}% Zeitersparnis)")
            self.log_signal.emit("================================================================================\n")

        success = (exit_code == 0)
        summary = f"Testausführung beendet (Exit Code: {exit_code}). Berichte in 'results/' gespeichert."
        self.log_signal.emit(f"=== {summary} ===\n")
        self.finished_signal.emit(success, summary)

    def _listener_callback(self, event_type: str, data: dict):
        if event_type == "step_start":
            self.progress_signal.emit(data.get("step", 0), data.get("keyword", ""))
        elif event_type == "waiting_for_step":
            self.step_waiting_signal.emit(data.get("step", 0), data.get("keyword", ""))
        elif event_type == "test_end":
            duration_ms = data.get("duration_ms", 0)
            status = data.get("status", "PASS")
            test_name = data.get("test_name", "")
            parent_name = data.get("parent_name", "")
            longname = data.get("longname", "")

            from libraries.routine_manager import RoutineManager
            mgr = RoutineManager()
            all_routines = mgr.list_routines()

            matched_routine = None

            # 1. Match from parent_name (e.g. "Test Qwer" or "test_qwer")
            if parent_name:
                p_clean = parent_name.replace("Test ", "").replace("test_", "").strip().lower()
                for r in all_routines:
                    r_name = r.get("routine_name", "").lower()
                    if r_name == p_clean:
                        matched_routine = r.get("routine_name")
                        break

            # 2. Match from test_name (e.g. "Verify Recorded Routine Block Qwer")
            if not matched_routine and test_name:
                t_clean = test_name.replace("Verify Recorded Routine Block ", "").strip().lower()
                for r in all_routines:
                    r_name = r.get("routine_name", "").lower()
                    if r_name == t_clean or r_name in t_clean:
                        matched_routine = r.get("routine_name")
                        break

            # 3. Match from longname or test_file_paths fallback
            if not matched_routine and longname:
                l_clean = longname.lower()
                for r in all_routines:
                    r_name = r.get("routine_name", "").lower()
                    if r_name in l_clean:
                        matched_routine = r.get("routine_name")
                        break

            if matched_routine:
                exec_stats = mgr.update_routine_execution_stats(matched_routine, duration_ms, status)
                if exec_stats:
                    self.routine_benchmarks.append({
                        "routine_name": matched_routine,
                        "exec_stats": exec_stats
                    })

    @Slot(int)
    def update_slowmo(self, ms: int):
        self.slowmo_ms = ms
        if self.speed_mode == "SLOWMO":
            execution_state.set_slowmo(ms)

    @Slot()
    def trigger_next_step(self):
        execution_state.next_step()
