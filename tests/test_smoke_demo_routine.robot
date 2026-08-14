*** Settings ***
Documentation    Automated test execution suite for recorded routine 'smoke_demo_routine'.
Resource         ../resources/common.resource
Resource         ../resources/page_objects/smoke_demo_routine.resource
Test Setup       Setup Web Test Browser
Test Teardown    Teardown Web Test Browser

*** Test Cases ***
Verify Recorded Routine Block Smoke Demo Routine
    [Documentation]    Runs recorded user interactions as a test block.
    [Tags]             routine    recorded
    Execute Routine Smoke Demo Routine

