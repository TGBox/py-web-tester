"""
Main entry point for py-web-tester workspace.
Provides CLI execution delegation and an interactive console menu for launching the PySide6 GUI,
recording routines, and running test suites.
"""

import sys
import os
from pathlib import Path
from run_tests import main as run_tests_main

def interactive_menu():
    print("\n=======================================================")
    print(" PY-WEB-TESTER AUTOMATION FRAMEWORK")
    print("=======================================================")
    print(" 1) Launch Graphical User Interface (GUI)")
    print(" 2) Run Automated Test Suites (CLI)")
    print(" 3) Record New Interactive Test Routine Block (CLI)")
    print(" 4) List Recorded Test Routines")
    print(" 5) Exit")
    print("-------------------------------------------------------")
    
    try:
        choice = input(" Select an option (1-5): ").strip()
        if choice == "1":
            print("\n [GUI] Launching PySide6 Application Window...")
            from app import main as app_main
            app_main()
        elif choice == "2":
            sys.argv = [sys.argv[0]]
            run_tests_main()
        elif choice == "3":
            url = input(" Enter target URL [https://example.com]: ").strip() or "https://example.com"
            name = input(" Enter routine block name [my_routine]: ").strip() or "my_routine"
            from libraries.routine_recorder import RoutineRecorder
            recorder = RoutineRecorder()
            res = recorder.record_routine(url=url, routine_name=name)
            print(f"\n [OK] Routine recorded! Test file: {res['test_path']}")
        elif choice == "4":
            from libraries.routine_manager import RoutineManager
            mgr = RoutineManager()
            routines = mgr.list_routines()
            if not routines:
                print("\n No recorded routines found in 'routines/' directory.")
            else:
                print("\n Recorded Test Routines:")
                for r in routines:
                    tags = f" [tags: {', '.join(r.get('tags', []))}]" if r.get('tags') else ""
                    print(f"   - {r.get('routine_name')} ({r.get('formatted_date')}){tags}")
        elif choice == "5":
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
