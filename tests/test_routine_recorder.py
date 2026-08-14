"""
Unit & Integration Tests for Interactive Test Routine Recorder, Converter, and Executor.
"""

import unittest
import json
import shutil
import tempfile
from pathlib import Path

from libraries.routine_converter import RoutineConverter
from libraries.routine_recorder import RoutineRecorder

class TestRoutineRecorder(unittest.TestCase):
    def setUp(self):
        self.temp_dir = tempfile.mkdtemp()
        self.output_dir = Path(self.temp_dir) / "routines"
        self.resources_dir = Path(self.temp_dir) / "resources"
        self.tests_dir = Path(self.temp_dir) / "tests"

        self.converter = RoutineConverter(
            resources_dir=str(self.resources_dir),
            tests_dir=str(self.tests_dir)
        )

    def tearDown(self):
        shutil.rmtree(self.temp_dir, ignore_errors=True)

    def test_js_script_generation(self):
        recorder = RoutineRecorder(
            output_dir=str(self.output_dir),
            resources_dir=str(self.resources_dir),
            tests_dir=str(self.tests_dir)
        )
        js_code = recorder.get_js_recorder_script()
        self.assertIn("py-web-tester-recorder-hud", js_code)
        self.assertIn("STOP RECORDING", js_code)
        self.assertIn("__PY_WEB_TESTER_EVENT__", js_code)
        self.assertIn("emitEvent", js_code)

    def test_record_routine_url_kwarg_alias(self):
        recorder = RoutineRecorder(
            output_dir=str(self.output_dir),
            resources_dir=str(self.resources_dir),
            tests_dir=str(self.tests_dir)
        )
        # Verify method signature accepts both url= and start_url= without raising TypeError
        import inspect
        sig = inspect.signature(recorder.record_routine)
        self.assertIn("start_url", sig.parameters)
        self.assertIn("url", sig.parameters)


    def test_json_to_resource_and_test_conversion(self):
        sample_json_data = {
            "routine_name": "DataCur-Login-Instanz-DR",
            "recorded_at": "2026-08-14T16:30:00Z",
            "start_url": "https://dr.data-al.cloud",
            "duration_ms": 12000,
            "total_actions": 4,
            "actions": [
                {
                    "action_id": 1,
                    "elapsed_ms": 500,
                    "event_type": "navigate",
                    "page_url": "https://dr.data-al.cloud"
                },
                {
                    "action_id": 2,
                    "elapsed_ms": 1000,
                    "event_type": "click",
                    "element": {
                        "tag": "INPUT",
                        "selector": "input#username",
                        "placeholder": "Enter Username"
                    }
                },
                {
                    "action_id": 3,
                    "elapsed_ms": 2500,
                    "event_type": "input",
                    "value": "admin_user",
                    "element": {
                        "tag": "INPUT",
                        "selector": "input#username"
                    }
                },
                {
                    "action_id": 4,
                    "elapsed_ms": 4000,
                    "event_type": "click",
                    "element": {
                        "tag": "BUTTON",
                        "selector": "button#submit-btn",
                        "text": "Sign In"
                    }
                }
            ]
        }

        json_path = self.output_dir / "DataCur-Login-Instanz-DR.json"
        self.output_dir.mkdir(parents=True, exist_ok=True)
        with open(json_path, "w", encoding="utf-8") as f:
            json.dump(sample_json_data, f)

        res = self.converter.convert_json_to_resource_and_test(json_path)

        resource_file = Path(res["resource_path"])
        test_file = Path(res["test_path"])

        self.assertTrue(resource_file.exists())
        self.assertTrue(test_file.exists())

        resource_content = resource_file.read_text(encoding="utf-8")
        test_content = test_file.read_text(encoding="utf-8")

        # Verify resource content & clean variable names
        self.assertIn("*** Settings ***", resource_content)
        self.assertIn("${DATACUR_LOGIN_INSTANZ_DR_START_URL}", resource_content)
        self.assertIn("Execute Routine Datacur Login Instanz Dr", resource_content)
        self.assertIn("Go To    https://dr.data-al.cloud", resource_content)
        self.assertIn("Fill Text", resource_content)
        self.assertIn("admin_user", resource_content)
        self.assertIn("Click", resource_content)

        # Verify test file content
        self.assertIn("*** Test Cases ***", test_content)
        self.assertIn("Execute Routine Datacur Login Instanz Dr", test_content)
        self.assertIn("Test Setup", test_content)

if __name__ == "__main__":
    unittest.main()
