*** Settings ***
Documentation    Automated test execution suite for recorded routine 'test'.
Resource         ../resources/common.resource
Resource         ../resources/page_objects/test.resource
Test Setup       Setup Web Test Browser
Test Teardown    Teardown Web Test Browser

*** Test Cases ***
Verify Recorded Routine Block Test
    [Documentation]    Runs recorded user interactions as a test block.
    [Tags]             routine    recorded
    Execute Routine Test

