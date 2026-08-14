import os
import json
from robot.api.deco import keyword, library

@library(scope='GLOBAL')
class web_helpers:
    """
    Helper keywords for system, environment, or data formatting operations.
    """

    @keyword("Check File Exists And Non Empty")
    def check_file_exists_and_non_empty(self, file_path: str) -> bool:
        """
        Verifies if a file exists and has size > 0.
        """
        if not os.path.exists(file_path):
            raise AssertionError(f"File does not exist: {file_path}")
        if os.path.getsize(file_path) == 0:
            raise AssertionError(f"File is empty: {file_path}")
        return True

    @keyword("Parse Json String To Dict")
    def parse_json_string_to_dict(self, json_str: str) -> dict:
        """
        Parses a JSON string into a Python dictionary.
        """
        return json.loads(json_str)
