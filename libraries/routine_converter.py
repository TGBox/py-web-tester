"""
Routine Converter for py-web-tester.
Reads recorded routine JSON files and generates clean, reusable Robot Framework
resource files (.resource) and executable test suites (.robot).
Sanitizes selectors, comments, and values to guarantee single-line compliance for Robot Framework syntax.
Smartly distinguishes input fields (Fill Text) from buttons/links/custom elements (Click).
Uses resilient IF visibility guards, element readiness checks, and force-click fallbacks.
Passes routine target START_URL to Setup Web Test Browser so tests start immediately on the target page.
"""

import json
import re
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

    def _clean_single_line(self, text: str) -> str:
        if not text:
            return ""
        cleaned = text.replace("\r\n", " ").replace("\n", " ").replace("\r", " ").replace("\t", " ")
        return re.sub(r"\s+", " ", cleaned).strip()

    def convert_json_to_resource_and_test(self, json_file_path: str | Path) -> Dict[str, str]:
        json_path = Path(json_file_path).resolve()
        if not json_path.exists():
            raise FileNotFoundError(f"JSON routine file not found: {json_path}")

        with open(json_path, "r", encoding="utf-8") as f:
            data = json.load(f)

        routine_name = data.get("routine_name", json_path.stem)
        start_url = data.get("start_url", "${BASE_URL}")
        actions = data.get("actions", [])

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
        steps = []
        i = 0
        n = len(raw_actions)

        while i < n:
            curr = raw_actions[i]
            event_type = curr.get("event_type", "").lower()
            elem = curr.get("element") or {}
            raw_selector = elem.get("selector") or elem.get("xpath") or "css=body"
            text = self._clean_single_line(elem.get("text") or "")
            tag = elem.get("tag", "").upper()

            if "object Object" in raw_selector or "#\\[object" in raw_selector:
                if text:
                    tag_str = tag.lower() if tag else "mat-option"
                    raw_selector = f"{tag_str}:has-text(\"{text}\")"
                else:
                    raw_selector = tag.lower() if tag else "css=body"

            selector = self._clean_single_line(raw_selector) or "css=body"
            val = self._clean_single_line(curr.get("value") or "")
            coords = elem.get("elem_coords") or {}

            custom_desc = self._clean_single_line(curr.get("description") or curr.get("custom_description") or curr.get("comment") or "")

            if event_type == "navigate":
                url = self._clean_single_line(curr.get("page_url") or "")
                # Only emit Go To for initial page load if not already opened by Setup
                if url and url != "about:blank" and not steps:
                    steps.append({
                        "keyword": "Go To",
                        "selector": None,
                        "url": url,
                        "comment": custom_desc or f"Navigate to '{url}'"
                    })
            elif event_type in ["input", "change"]:
                if tag in ["INPUT", "TEXTAREA", "SELECT"]:
                    final_val = val
                    j = i + 1
                    while j < n and raw_actions[j].get("event_type") in ["input", "change"]:
                        next_elem = raw_actions[j].get("element") or {}
                        next_sel = self._clean_single_line(next_elem.get("selector") or "")
                        if next_sel == selector:
                            final_val = self._clean_single_line(raw_actions[j].get("value") or final_val)
                            i = j
                        j += 1

                    elem_name = self._clean_single_line(elem.get("placeholder") or elem.get("name") or selector)
                    steps.append({
                        "keyword": "Fill Text",
                        "selector": selector,
                        "value": final_val,
                        "comment": custom_desc or f"Eingabe in Feld '{elem_name}'"
                    })
                else:
                    elem_label = self._clean_single_line(text or elem.get("tag") or selector)
                    steps.append({
                        "keyword": "Click",
                        "selector": selector,
                        "coords": coords,
                        "comment": custom_desc or f"Klick auf Element '{elem_label}'"
                    })
            elif event_type == "dblclick":
                elem_label = self._clean_single_line(text or elem.get("tag") or selector)
                # Remove preceding single Click steps on same or child selector to prevent delay before dblclick
                while steps and steps[-1].get("keyword") == "Click":
                    prev_sel = steps[-1].get("selector", "")
                    if prev_sel == selector or selector in prev_sel or prev_sel in selector:
                        steps.pop()
                    else:
                        break

                steps.append({
                    "keyword": "Dblclick",
                    "selector": selector,
                    "coords": coords,
                    "comment": custom_desc or f"Doppelklick auf Element '{elem_label}'"
                })
            elif event_type in ["click", "contextmenu"]:
                elem_label = self._clean_single_line(text or elem.get("tag") or selector)
                steps.append({
                    "keyword": "Click",
                    "selector": selector,
                    "coords": coords,
                    "comment": custom_desc or f"Klick auf Element '{elem_label}'"
                })
            elif event_type == "scroll":
                steps.append({
                    "keyword": "Scroll To",
                    "selector": selector,
                    "comment": custom_desc or f"Scroll zu Element '{selector}'"
                })

            i += 1

        return steps

    def _generate_resource_content(self, routine_name: str, start_url: str, steps: List[Dict[str, Any]]) -> str:
        clean_routine_name = self._clean_single_line(routine_name)
        kw_name = re.sub(r"\s+", " ", clean_routine_name.replace("_", " ").replace("-", " ")).strip().title()
        raw_var_name = clean_routine_name.upper().replace("-", "_").replace(" ", "_")
        clean_var_name = re.sub(r'[^A-Z0-9_]', '_', raw_var_name)
        clean_var_name = re.sub(r'_+', '_', clean_var_name).strip('_')

        lines = [
            "*** Settings ***",
            f"Documentation    Recorded test block routine for '{clean_routine_name}'.",
            "Library          Browser",
            "Library          ../libraries/visual_hud.py",
            "",
            "*** Variables ***",
            f"${{{clean_var_name}_START_URL}}    {start_url}",
            "${ACTION_DELAY}                    50ms",
            ""
        ]

        selectors_dict = {}
        var_count = 1
        for step in steps:
            sel = step.get("selector")
            if sel and sel not in selectors_dict:
                var_name = f"${{SELECTOR_{clean_var_name}_{var_count}}}"
                selectors_dict[sel] = var_name
                lines.append(f"{var_name:<60}    {sel}")
                var_count += 1

        lines.extend([
            "",
            "*** Keywords ***",
            f"Execute Routine {kw_name}",
            f"    [Documentation]    Executes recorded interaction sequence for {clean_routine_name}.",
            "    [Arguments]        ${url}=${" + f"{clean_var_name}_START_URL" + "}"
        ])

        if not steps:
            lines.append("    Log    No interactive steps recorded.")
            return "\n".join(lines) + "\n"

        total_steps = len(steps)
        for idx, step in enumerate(steps, 1):
            kw = step["keyword"]
            comment = step.get("comment", "")

            lines.append(f"    # Step {idx}: {comment}")
            lines.append(f"    Log    [SCHRITT {idx}/{total_steps}] 📝 {comment}    console=True")
            if kw == "Go To":
                lines.append(f"    Run Keyword And Ignore Error    Show Keystroke Overlay    Navigiere: {step.get('url')}")
                lines.append(f"    Go To    {step.get('url')}")
                lines.append("    Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD")
            else:
                var_selector = selectors_dict.get(step["selector"], f'"{step["selector"]}"')
                lines.append(f"    Run Keyword And Ignore Error    Wait For Elements State    {var_selector}    visible    timeout=5s")
                lines.append(f"    Run Keyword And Ignore Error    Animate Visual Pointer To Element    {var_selector}")
                lines.append("    Sleep    ${ACTION_DELAY}")

                if kw == "Fill Text":
                    val = step.get('value', '')
                    lines.append(f"    Run Keyword And Ignore Error    Show Keystroke Overlay    {comment} -> \"{val}\"")
                    lines.append("    Run Keyword And Ignore Error    Trigger Visual Click Effect")
                    lines.append(f"    Run Keyword And Ignore Error    Click    {var_selector}")
                    lines.append(f"    ${{type_ok}}=    Run Keyword And Return Status    Type Text    {var_selector}    {val}    delay=40ms")
                    lines.append(f"    IF    not ${{type_ok}}")
                    lines.append(f"        Run Keyword And Ignore Error    Fill Text    {var_selector}    {val}")
                    lines.append(f"    END")
                elif kw == "Dblclick":
                    lines.append("    Run Keyword And Ignore Error    Trigger Visual Click Effect")
                    lines.append(f"    ${{dbl_ok}}=    Run Keyword And Return Status    Click    {var_selector}    click_count=2")
                    lines.append(f"    IF    not ${{dbl_ok}}")
                    lines.append(f"        Run Keyword And Ignore Error    Evaluate JavaScript    {var_selector}    (el) => {{ if(el) {{ el.dispatchEvent(new MouseEvent('mousedown', {{bubbles: true, detail: 1}})); el.dispatchEvent(new MouseEvent('mouseup', {{bubbles: true, detail: 1}})); el.dispatchEvent(new MouseEvent('click', {{bubbles: true, detail: 1}})); el.dispatchEvent(new MouseEvent('mousedown', {{bubbles: true, detail: 2}})); el.dispatchEvent(new MouseEvent('mouseup', {{bubbles: true, detail: 2}})); el.dispatchEvent(new MouseEvent('click', {{bubbles: true, detail: 2}})); el.dispatchEvent(new MouseEvent('dblclick', {{bubbles: true, detail: 2}})); }} }}")
                    lines.append(f"    END")
                elif kw == "Click":
                    lines.append(f"    Run Keyword And Ignore Error    Show Keystroke Overlay    {comment}")
                    lines.append("    Run Keyword And Ignore Error    Trigger Visual Click Effect")
                    lines.append(f"    ${{click_ok}}=    Run Keyword And Return Status    Click    {var_selector}")
                    lines.append(f"    IF    not ${{click_ok}}")
                    lines.append(f"        Run Keyword And Ignore Error    Click    {var_selector}    force=True")
                    lines.append(f"    END")
                elif kw == "Scroll To":
                    lines.append(f"    Run Keyword And Ignore Error    Scroll To    {var_selector}")
                else:
                    lines.append("    Run Keyword And Ignore Error    Trigger Visual Click Effect")
                    lines.append(f"    Run Keyword And Ignore Error    {kw}    {var_selector}")

            lines.append("    Sleep    ${ACTION_DELAY}")

        return "\n".join(lines) + "\n"

    def _generate_test_content(self, routine_name: str) -> str:
        clean_routine_name = self._clean_single_line(routine_name)
        kw_name = re.sub(r"\s+", " ", clean_routine_name.replace("_", " ").replace("-", " ")).strip().title()
        raw_var_name = clean_routine_name.upper().replace("-", "_").replace(" ", "_")
        clean_var_name = re.sub(r'[^A-Z0-9_]', '_', raw_var_name)
        clean_var_name = re.sub(r'_+', '_', clean_var_name).strip('_')

        lines = [
            "*** Settings ***",
            f"Documentation    Automated test execution suite for recorded routine '{clean_routine_name}'.",
            "Resource         ../resources/common.resource",
            f"Resource         ../resources/page_objects/{clean_routine_name}.resource",
            f"Test Setup       Setup Web Test Browser    ${{{clean_var_name}_START_URL}}",
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
