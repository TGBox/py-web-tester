import os
import shutil
import tempfile
import unittest
from pathlib import Path
from libraries.routine_manager import RoutineManager

class TestRoutineManager(unittest.TestCase):
    def setUp(self):
        self.temp_dir = tempfile.mkdtemp()
        self.routines_dir = os.path.join(self.temp_dir, "routines")
        self.groups_dir = os.path.join(self.temp_dir, "groups")
        self.suites_dir = os.path.join(self.temp_dir, "suites")
        
        self.manager = RoutineManager(
            routines_dir=self.routines_dir,
            groups_dir=self.groups_dir,
            suites_dir=self.suites_dir
        )

    def tearDown(self):
        shutil.rmtree(self.temp_dir, ignore_errors=True)

    def test_save_and_get_routine(self):
        actions = [
            {"action_id": 1, "event_type": "click", "element": {"selector": "#btn"}}
        ]
        saved_path = self.manager.save_routine(
            routine_name="login_flow",
            actions=actions,
            start_url="https://dr.data-al.cloud",
            description="Test login routine",
            tags=["login", "smoke"]
        )
        self.assertTrue(Path(saved_path).exists())

        routine = self.manager.get_routine("login_flow")
        self.assertIsNotNone(routine)
        self.assertEqual(routine["routine_name"], "login_flow")
        self.assertEqual(routine["description"], "Test login routine")
        self.assertIn("login", routine["tags"])
        self.assertEqual(len(routine["actions"]), 1)

    def test_filter_routines_by_tag_and_search(self):
        self.manager.save_routine("routine_a", [], description="Admin panel", tags=["admin", "smoke"])
        self.manager.save_routine("routine_b", [], description="Patient view", tags=["patient"])
        self.manager.save_routine("routine_c", [], description="Logout routine", tags=["smoke"])

        # Filter by tag 'smoke'
        smoke_routines = self.manager.filter_routines(tag_filter="smoke")
        self.assertEqual(len(smoke_routines), 2)
        names = [r["routine_name"] for r in smoke_routines]
        self.assertIn("routine_a", names)
        self.assertIn("routine_c", names)

        # Filter by query search
        search_res = self.manager.filter_routines(search_text="patient")
        self.assertEqual(len(search_res), 1)
        self.assertEqual(search_res[0]["routine_name"], "routine_b")

    def test_routine_group_operations(self):
        group_path = self.manager.save_group(
            group_name="FullLoginGroup",
            routine_names=["routine_a", "routine_b"],
            description="Runs login and patient view"
        )
        self.assertTrue(Path(group_path).exists())

        group = self.manager.get_group("FullLoginGroup")
        self.assertIsNotNone(group)
        self.assertEqual(group["group_name"], "FullLoginGroup")
        self.assertEqual(len(group["routine_names"]), 2)

    def test_master_test_suite_operations(self):
        items = [
            {"type": "group", "name": "FullLoginGroup"},
            {"type": "routine", "name": "routine_c"}
        ]
        suite_path = self.manager.save_suite(
            suite_name="RegressionSuite",
            items=items,
            description="Full regression suite"
        )
        self.assertTrue(Path(suite_path).exists())

        suite = self.manager.get_suite("RegressionSuite")
        self.assertIsNotNone(suite)
        self.assertEqual(suite["suite_name"], "RegressionSuite")
        self.assertEqual(len(suite["items"]), 2)

if __name__ == "__main__":
    unittest.main()
