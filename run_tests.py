"""
Test Runner Script for Robot Framework Web UI Automation
Usage:
    python run_tests.py [--tag smoke] [--browser firefox] [--headed]
"""

import sys
import argparse
from pathlib import Path
import robot

def main():
    parser = argparse.ArgumentParser(description="Run Web UI Automated Test Suites")
    parser.add_argument("--tag", "-t", type=str, help="Include tests with specific tag (e.g. smoke, e2e, login)")
    parser.add_argument("--exclude", "-e", type=str, help="Exclude tests with specific tag")
    parser.add_argument("--browser", "-b", type=str, choices=["chromium", "firefox", "webkit"], help="Override browser engine")
    parser.add_argument("--headed", action="store_true", help="Run browser in visible (headed) mode")
    parser.add_argument("--suite", "-s", type=str, help="Path to specific robot suite file")
    
    args = parser.parse_args()

    project_root = Path(__file__).parent.resolve()
    results_dir = project_root / "results"
    tests_dir = project_root / "tests"

    robot_args = [
        "--outputdir", str(results_dir),
        "--pythonpath", str(project_root),
        "--loglevel", "INFO",
    ]

    if args.tag:
        robot_args.extend(["--include", args.tag])

    if args.exclude:
        robot_args.extend(["--exclude", args.exclude])

    if args.browser:
        robot_args.extend(["--variable", f"BROWSER:{args.browser}"])

    if args.headed:
        robot_args.extend(["--variable", "HEADLESS:False"])

    target_suite = str(project_root / args.suite) if args.suite else str(tests_dir)
    robot_args.append(target_suite)

    print(f"Executing Robot Framework with args: {robot_args}\n")
    exit_code = robot.run_cli(robot_args, exit=False)

    print(f"\nTest Execution Completed with Exit Code: {exit_code}")
    print(f"Reports saved in: {results_dir / 'report.html'}")

    sys.exit(exit_code)

if __name__ == "__main__":
    main()
