"""
Custom Robot Framework Execution Listener for py-web-tester.
Hooks into keyword execution for:
- Slow-Mo execution delays (0 to 2000 ms)
- Step-by-Step manual execution mode (pausing via threading.Event until 'Next Step' is triggered)
- Real-time step progress reporting to PySide6 Execution Controller QThread.
"""

import time
import threading
from typing import Dict, Any, Optional

class ExecutionState:
    """Thread-safe global state shared between PySide6 GUI controller and Robot Framework Listener."""
    def __init__(self):
        self.slowmo_ms: int = 0
        self.manual_mode: bool = False
        self.paused: bool = False
        self.step_event = threading.Event()
        self.step_event.set()  # Default to open (non-blocking)
        self.callback = None

    def set_slowmo(self, ms: int):
        self.slowmo_ms = max(0, ms)

    def set_manual_mode(self, enabled: bool):
        self.manual_mode = enabled
        if not enabled:
            self.step_event.set()
        else:
            self.step_event.clear()

    def next_step(self):
        """Releases lock for one step."""
        self.step_event.set()

    def reset(self):
        self.slowmo_ms = 0
        self.manual_mode = False
        self.paused = False
        self.step_event.set()

# Singleton execution state instance
execution_state = ExecutionState()

class StepListener:
    ROBOT_LISTENER_API_VERSION = 3

    def __init__(self):
        self.state = execution_state
        self.step_count = 0
        self.test_start_time = time.time()

    def start_test(self, data: Any, result: Any):
        self.test_start_time = time.time()
        self.test_name = getattr(data, 'name', '')

    def end_test(self, data: Any, result: Any):
        duration_ms = int((time.time() - getattr(self, 'test_start_time', time.time())) * 1000)
        test_name = getattr(data, 'name', '')
        longname = getattr(data, 'longname', '')
        parent_name = getattr(getattr(data, 'parent', None), 'name', '')

        if self.state.callback:
            self.state.callback("test_end", {
                "test_name": test_name,
                "parent_name": parent_name,
                "longname": longname,
                "duration_ms": duration_ms,
                "status": getattr(result, 'status', 'PASS')
            })

    def start_keyword(self, data: Any, result: Any):
        # Ignore internal setup/teardown keywords
        kw_name = data.name.strip()
        if kw_name.startswith("BuiltIn.") or kw_name.startswith("Browser.Close") or kw_name.startswith("Browser.New"):
            return

        self.step_count += 1

        # Check if running in Headed mode (HEADLESS=FALSE)
        try:
            from robot.libraries.BuiltIn import BuiltIn
            headless_var = BuiltIn().get_variable_value("${HEADLESS}", "TRUE")
            is_headed = str(headless_var).upper() in ["FALSE", "0", "OFF", "NO"]
        except Exception:
            is_headed = False

        if is_headed:
            try:
                from libraries.visual_hud import visual_hud
                hud_instance = visual_hud()
                hud_instance.inject_visual_hud()

                # If first arg is a selector, glide visual pointer to it
                if hasattr(data, "args") and data.args:
                    first_arg = str(data.args[0])
                    if not first_arg.startswith("http") and not first_arg.isdigit() and len(first_arg) > 1:
                        hud_instance.animate_visual_pointer(first_arg)
            except Exception:
                pass

        # Emit step notification to GUI if callback attached
        if self.state.callback:
            self.state.callback("step_start", {
                "step": self.step_count,
                "keyword": kw_name,
                "args": list(data.args) if hasattr(data, "args") else []
            })

        # Apply Slow-Mo delay if set
        if self.state.slowmo_ms > 0:
            time.sleep(self.state.slowmo_ms / 1000.0)

        # Handle Manual Step-by-Step Mode
        if self.state.manual_mode:
            # Block until step_event is set by GUI "Nächster Schritt" button click
            if self.state.callback:
                self.state.callback("waiting_for_step", {
                    "step": self.step_count,
                    "keyword": kw_name
                })
            self.state.step_event.wait()
            # Clear event so next keyword blocks again
            self.state.step_event.clear()

    def end_keyword(self, data: Any, result: Any):
        kw_name = data.name.strip()
        if kw_name.startswith("BuiltIn.") or kw_name.startswith("Browser.Close") or kw_name.startswith("Browser.New"):
            return

        if self.state.callback:
            self.state.callback("step_end", {
                "step": self.step_count,
                "keyword": kw_name,
                "status": result.status
            })
