*** Settings ***
Documentation    Automated test execution suite for recorded routine 'asd'.
Resource         ../resources/common.resource
Resource         ../resources/page_objects/asd.resource
Test Setup       Setup Web Test Browser    ${ASD_START_URL}
Test Teardown    Teardown Web Test Browser

*** Test Cases ***
Verify Recorded Routine Block Asd
    [Documentation]    Runs recorded user interactions as a test block.
    [Tags]             routine    recorded
    Execute Routine Asd

