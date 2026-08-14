"""
Robot Framework Custom Library for executing recorded JSON routine traces.
"""

import json
from pathlib import Path
from robot.api.deco import keyword, library
from robot.libraries.BuiltIn import BuiltIn

@library(scope='GLOBAL')
class routine_executor:
    """
    Keyword library for replaying recorded interaction JSON routines.
    """

    @keyword("Replay Recorded Routine")
    def replay_recorded_routine(self, routine_json_path: str, speed_delay_ms: int = 100) -> bool:
        """
        Reads a recorded routine JSON trace file and replays its sequence using Robot Framework Browser library keywords.
        Usage: Replay Recorded Routine    routines/login_flow.json
        """
        path = Path(routine_json_path).resolve()
        if not path.exists():
            raise FileNotFoundError(f"Routine JSON file not found: {path}")

        with open(path, "r", encoding="utf-8") as f:
            routine_data = json.load(f)

        actions = routine_data.get("actions", [])
        if not actions:
            BuiltIn().log(f"Routine '{routine_data.get('routine_name')}' contains no actions.")
            return True

        browser_lib = BuiltIn().get_library_instance("Browser")

        print(f"Replaying routine '{routine_data.get('routine_name')}' ({len(actions)} actions)...")

        for idx, act in enumerate(actions, 1):
            event_type = act.get("event_type", "").lower()
            elem = act.get("element") or {}
            selector = elem.get("selector") or elem.get("xpath") or "css=body"
            val = act.get("value")

            try:
                if event_type in ["click", "dblclick", "contextmenu"]:
                    browser_lib.wait_for_elements_state(selector, "visible", timeout="10s")
                    browser_lib.click(selector)
                elif event_type in ["input", "change"] and val is not None:
                    browser_lib.wait_for_elements_state(selector, "visible", timeout="10s")
                    browser_lib.fill_text(selector, str(val))
                elif event_type == "scroll":
                    browser_lib.scroll_to(selector)

                if speed_delay_ms > 0:
                    BuiltIn().sleep(f"{speed_delay_ms}ms")
            except Exception as e:
                BuiltIn().log(f"Warning on action #{idx} ({event_type} -> {selector}): {e}", level="WARN")

        return True
