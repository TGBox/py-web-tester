*** Settings ***
Documentation    Automated test execution suite for recorded routine 'test2'.
Resource         ../resources/common.resource
Resource         ../resources/page_objects/test2.resource
Test Setup       Setup Web Test Browser    ${TEST2_START_URL}
Test Teardown    Teardown Web Test Browser

*** Test Cases ***
Verify Recorded Routine Block Test2
    [Documentation]    Runs recorded user interactions as a test block.
    [Tags]             routine    recorded
    Execute Routine Test2

