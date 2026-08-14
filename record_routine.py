"""
CLI Script to Launch Interactive Test Routine Recorder.
Usage:
    python record_routine.py [--url https://example.com] [--name my_test_routine]
"""

import sys
import argparse
from pathlib import Path
from libraries.routine_recorder import RoutineRecorder

def main():
    parser = argparse.ArgumentParser(description="Interactive Web UI Test Routine Recorder")
    parser.add_argument("--url", "-u", type=str, default="https://example.com", help="Initial target URL to open for recording")
    parser.add_argument("--name", "-n", type=str, default="interactive_routine", help="Name of the test routine block to save")
    parser.add_argument("--output", "-o", type=str, default="routines", help="Directory to save JSON routine traces")
    parser.add_argument("--resources", type=str, default="resources/page_objects", help="Directory to save generated Robot resource blocks")
    parser.add_argument("--tests", type=str, default="tests", help="Directory to save generated executable Robot test suites")
    parser.add_argument("--timeout", "-t", type=int, default=0, help="Optional recording timeout in seconds (0 = unlimited)")
    parser.add_argument("--headless", action="store_true", help="Run recorder in headless mode")

    args = parser.parse_args()

    recorder = RoutineRecorder(
        output_dir=args.output,
        resources_dir=args.resources,
        tests_dir=args.tests
    )

    try:
        result = recorder.record_routine(
            start_url=args.url,
            routine_name=args.name,
            headless=args.headless,
            timeout_seconds=args.timeout
        )

        print("\n=======================================================")
        print(" [SUCCESS] ROUTINE RECORDING & CONVERSION COMPLETED!")
        print(f"  JSON Routine Trace : {result['json_path']}")
        print(f"  Robot Resource Block: {result['resource_path']}")
        print(f"  Executable Test     : {result['test_path']}")
        print("-------------------------------------------------------")
        print(f" To run your new recorded routine block, execute:")
        print(f"   python run_tests.py --suite {result['test_path']}")
        print("=======================================================\n")

    except KeyboardInterrupt:
        print("\nRecording cancelled by user.")
        sys.exit(1)
    except Exception as ex:
        print(f"\n [ERROR] Error during recording: {ex}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()
