"""
Routine Converter for py-web-tester.
Reads recorded routine JSON files and generates clean, reusable Robot Framework
resource files (.resource) and executable test suites (.robot).
"""

import json
from pathlib import Path
from typing import Dict, List, Any

class RoutineConverter:
    def __init__(
        self,
        resources_dir: str = "resources/page_objects",
        tests_dir: str = "tests"
    ):
        self.resources_dir = Path(resources_dir).resolve()
        self.tests_dir = Path(tests_dir).resolve()
        
        self.resources_dir.mkdir(parents=True, exist_ok=True)
        self.tests_dir.mkdir(parents=True, exist_ok=True)

    def convert_json_to_resource_and_test(self, json_file_path: str | Path) -> Dict[str, str]:
        json_path = Path(json_file_path).resolve()
        if not json_path.exists():
            raise FileNotFoundError(f"JSON routine file not found: {json_path}")

        with open(json_path, "r", encoding="utf-8") as f:
            data = json.load(f)

        routine_name = data.get("routine_name", json_path.stem)
        start_url = data.get("start_url", "${BASE_URL}")
        actions = data.get("actions", [])

        # Process and optimize actions
        processed_steps = self._process_actions(actions)

        # Build Resource File Content
        resource_content = self._generate_resource_content(routine_name, start_url, processed_steps)
        resource_file_path = self.resources_dir / f"{routine_name}.resource"
        with open(resource_file_path, "w", encoding="utf-8") as f:
            f.write(resource_content)

        # Build Executable Test Suite File Content
        test_content = self._generate_test_content(routine_name)
        test_file_path = self.tests_dir / f"test_{routine_name}.robot"
        with open(test_file_path, "w", encoding="utf-8") as f:
            f.write(test_content)

        print(f"  [CONVERTER] Created Resource Block: {resource_file_path}")
        print(f"  [CONVERTER] Created Robot Suite   : {test_file_path}")

        return {
            "resource_path": str(resource_file_path),
            "test_path": str(test_file_path)
        }

    def _process_actions(self, raw_actions: List[Dict[str, Any]]) -> List[Dict[str, Any]]:
        """
        Deduplicates and structures raw captured browser events into high-level Robot Framework steps.
        """
        steps = []
        i = 0
        n = len(raw_actions)

        while i < n:
            curr = raw_actions[i]
            event_type = curr.get("event_type", "").lower()
            elem = curr.get("element") or {}
            selector = elem.get("selector") or elem.get("xpath") or "css=body"
            val = curr.get("value") or ""
            text = elem.get("text") or ""
            coords = elem.get("elem_coords") or {}

            if event_type == "navigate":
                url = curr.get("page_url")
                if url and url != "about:blank":
                    steps.append({
                        "keyword": "Go To",
                        "selector": None,
                        "url": url,
                        "comment": f"Navigate to '{url}'"
                    })
            elif event_type in ["input", "change"]:
                # Consolidate consecutive inputs on the same element into one Fill Text step
                final_val = val
                j = i + 1
                while j < n and raw_actions[j].get("event_type") in ["input", "change"]:
                    next_elem = raw_actions[j].get("element") or {}
                    if next_elem.get("selector") == selector:
                        final_val = raw_actions[j].get("value") or final_val
                        i = j
                    j += 1

                steps.append({
                    "keyword": "Fill Text",
                    "selector": selector,
                    "value": final_val,
                    "comment": f"Fill input field '{elem.get('placeholder') or elem.get('name') or selector}'"
                })
            elif event_type in ["click", "dblclick", "contextmenu"]:
                steps.append({
                    "keyword": "Click",
                    "selector": selector,
                    "coords": coords,
                    "comment": f"Click element '{text or elem.get('tag') or selector}'"
                })
            elif event_type == "scroll":
                steps.append({
                    "keyword": "Scroll To",
                    "selector": selector,
                    "comment": f"Scroll to element '{selector}'"
                })

            i += 1

        return steps

    def _generate_resource_content(self, routine_name: str, start_url: str, steps: List[Dict[str, Any]]) -> str:
        kw_name = routine_name.replace("_", " ").replace("-", " ").title()
        clean_var_name = routine_name.upper().replace("-", "_").replace(" ", "_")

        lines = [
            "*** Settings ***",
            f"Documentation    Recorded test block routine for '{routine_name}'.",
            "Library          Browser",
            "",
            "*** Variables ***",
            f"${{{clean_var_name}_START_URL}}    {start_url}",
            ""
        ]

        # Generate variable selectors
        selectors_dict = {}
        var_count = 1
        for step in steps:
            sel = step.get("selector")
            if sel and sel not in selectors_dict:
                var_name = f"${{SELECTOR_{clean_var_name}_{var_count}}}"
                selectors_dict[sel] = var_name
                lines.append(f"{var_name:<35} {sel}")
                var_count += 1

        lines.extend([
            "",
            "*** Keywords ***",
            f"Execute Routine {kw_name}",
            f"    [Documentation]    Executes recorded interaction sequence for {routine_name}.",
            "    [Arguments]        ${url}=${" + f"{clean_var_name}_START_URL" + "}"
        ])

        if not steps:
            lines.append("    Log    No interactive steps recorded.")
            return "\n".join(lines) + "\n"

        for idx, step in enumerate(steps, 1):
            kw = step["keyword"]
            comment = step.get("comment", "")

            lines.append(f"    # Step {idx}: {comment}")
            if kw == "Go To":
                lines.append(f"    Go To    {step.get('url')}")
            else:
                var_selector = selectors_dict.get(step["selector"], f'"{step["selector"]}"')
                lines.append(f"    Wait For Elements State    {var_selector}    visible    timeout=10s")
                if kw == "Fill Text":
                    lines.append(f"    Fill Text    {var_selector}    {step.get('value', '')}")
                elif kw == "Click":
                    lines.append(f"    Click    {var_selector}")
                elif kw == "Scroll To":
                    lines.append(f"    Scroll To    {var_selector}")
                else:
                    lines.append(f"    {kw}    {var_selector}")

            lines.append("    Sleep    200ms")

        return "\n".join(lines) + "\n"

    def _generate_test_content(self, routine_name: str) -> str:
        kw_name = routine_name.replace("_", " ").replace("-", " ").title()
        
        lines = [
            "*** Settings ***",
            f"Documentation    Automated test execution suite for recorded routine '{routine_name}'.",
            "Resource         ../resources/common.resource",
            f"Resource         ../resources/page_objects/{routine_name}.resource",
            "Test Setup       Setup Web Test Browser",
            "Test Teardown    Teardown Web Test Browser",
            "",
            "*** Test Cases ***",
            f"Verify Recorded Routine Block {kw_name}",
            "    [Documentation]    Runs recorded user interactions as a test block.",
            "    [Tags]             routine    recorded",
            f"    Execute Routine {kw_name}",
            ""
        ]

        return "\n".join(lines) + "\n"
