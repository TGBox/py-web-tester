import random
import string
import re
from robot.api.deco import keyword, library

@library(scope='GLOBAL')
class custom_actions:
    """
    Custom Python keyword library for Robot Framework.
    This demonstrates how easily users can extend the test suite with Python functions
    for business logic, dynamic data generation, complex validations, and external integrations.
    """

    @keyword("Generate Unique Task Name")
    def generate_unique_task_name(self, prefix: str = "Test-Task") -> str:
        """
        Generates a unique task name with a random suffix.
        Example in Robot: ${task}=    Generate Unique Task Name    prefix=Buy
        """
        random_suffix = ''.join(random.choices(string.ascii_lowercase + string.digits, k=5))
        return f"{prefix}-{random_suffix}"

    @keyword("Verify Items Count Text Matches")
    def verify_items_count_text_matches(self, count_text: str, expected_count: int) -> bool:
        """
        Extracts numbers from a string like '3 items left' or '1 item left'
        and verifies if it equals expected_count.
        """
        numbers = re.findall(r'\d+', count_text)
        if not numbers:
            raise ValueError(f"No numeric value found in text: '{count_text}'")
        actual_count = int(numbers[0])
        if actual_count != int(expected_count):
            raise AssertionError(f"Count mismatch! Expected {expected_count}, but found {actual_count} in '{count_text}'")
        return True

    @keyword("Format Test Summary Log")
    def format_test_summary_log(self, test_name: str, status: str, details: str = "") -> str:
        """
        Formats a clean summary string for test reports.
        """
        divider = "=" * 40
        return f"\n{divider}\nTEST: {test_name}\nSTATUS: {status}\nDETAILS: {details}\n{divider}"
