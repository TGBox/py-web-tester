"""
Main entry point for py-web-tester workspace.
Provides CLI execution delegation and an interactive console menu for recording and replaying test routines.
"""

import sys
import os
from pathlib import Path
from run_tests import main as run_tests_main

def interactive_menu():
    print("\n=======================================================")
    print(" PY-WEB-TESTER AUTOMATION FRAMEWORK")
    print("=======================================================")
    print(" 1) Run Automated Test Suites")
    print(" 2) Record New Interactive Test Routine Block")
    print(" 3) List Recorded Test Routines")
    print(" 4) Exit")
    print("-------------------------------------------------------")
    
    try:
        choice = input(" Select an option (1-4): ").strip()
        if choice == "1":
            sys.argv = [sys.argv[0]]
            run_tests_main()
        elif choice == "2":
            url = input(" Enter target URL [https://example.com]: ").strip() or "https://example.com"
            name = input(" Enter routine block name [my_routine]: ").strip() or "my_routine"
            from libraries.routine_recorder import RoutineRecorder
            recorder = RoutineRecorder()
            res = recorder.record_routine(start_url=url, routine_name=name)
            print(f"\n [OK] Routine recorded! Test file: {res['test_path']}")
        elif choice == "3":
            routines_dir = Path("routines")
            if not routines_dir.exists() or not list(routines_dir.glob("*.json")):
                print("\n No recorded routines found in 'routines/' directory.")
            else:
                print("\n Recorded Test Routines:")
                for r in routines_dir.glob("*.json"):
                    print(f"   - {r.name}")

        elif choice == "4":
            print(" Goodbye!")
            sys.exit(0)
        else:
            print(" Invalid option selected.")
    except (KeyboardInterrupt, EOFError):
        print("\n Exiting...")
        sys.exit(0)

if __name__ == "__main__":
    if len(sys.argv) > 1:
        run_tests_main()
    else:
        interactive_menu()
