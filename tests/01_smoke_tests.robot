*** Settings ***
Documentation    Smoke tests to quickly verify application availability and core python integration.
Resource         ../resources/common.resource
Resource         ../resources/page_objects/todo_page.resource
Library          ../libraries/custom_actions.py
Library          ../libraries/web_helpers.py

Test Setup       Setup Web Test Browser
Test Teardown    Teardown Web Test Browser

*** Test Cases ***
Verify Web Application Title And Header
    [Documentation]    Ensures page loads successfully and title is correct.
    [Tags]             smoke    regression
    Get Title          contains    TodoMVC
    Get Element States    css=h1    contains    visible

Verify Custom Python Keyword Integration
    [Documentation]    Demonstrates executing custom Python logic within Robot test suite.
    [Tags]             smoke    python
    ${task_name}=      Generate Unique Task Name    prefix=SmokeTask
    Log                Generated task name: ${task_name}
    Add New Todo Item  ${task_name}
    Verify Todo Item Is Visible    ${task_name}
    Verify Remaining Count Equals  1
