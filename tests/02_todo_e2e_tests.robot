*** Settings ***
Documentation    End-to-End User Interaction Tests for Todo Application.
Resource         ../resources/common.resource
Resource         ../resources/page_objects/todo_page.resource
Library          ../libraries/custom_actions.py

Test Setup       Setup Web Test Browser
Test Teardown    Teardown Web Test Browser

*** Test Cases ***
User Can Add Multiple Items And Complete Them
    [Documentation]    Simulates a user adding 3 items, completing 1, and verifying remaining count.
    [Tags]             e2e    todo    regression

    ${item1}=          Generate Unique Task Name    prefix=E2E-Feature-A
    ${item2}=          Generate Unique Task Name    prefix=E2E-Feature-B
    ${item3}=          Generate Unique Task Name    prefix=E2E-Feature-C

    # Step 1: Add 3 items
    Add New Todo Item  ${item1}
    Add New Todo Item  ${item2}
    Add New Todo Item  ${item3}

    # Step 2: Verify all 3 items are present
    Verify Todo Item Is Visible    ${item1}
    Verify Todo Item Is Visible    ${item2}
    Verify Todo Item Is Visible    ${item3}
    Verify Remaining Count Equals  3

    # Step 3: Complete 1 item
    Mark Todo Item As Completed    ${item2}
    Verify Todo Item Is Completed  ${item2}

    # Step 4: Verify remaining count drops to 2
    Verify Remaining Count Equals  2

User Can Filter Completed And Active Tasks
    [Documentation]    Verifies filter view correctly isolates completed vs active items.
    [Tags]             e2e    filter

    ${active_item}=    Generate Unique Task Name    prefix=ActiveTask
    ${done_item}=      Generate Unique Task Name    prefix=DoneTask

    Add New Todo Item  ${active_item}
    Add New Todo Item  ${done_item}

    Mark Todo Item As Completed    ${done_item}

    # Filter Completed
    Filter By Completed
    Verify Todo Item Is Visible    ${done_item}
    Get Element States             xpath=//label[text()='${active_item}']    contains    detached

    # Filter Active
    Filter By Active
    Verify Todo Item Is Visible    ${active_item}
    Get Element States             xpath=//label[text()='${done_item}']    contains    detached
