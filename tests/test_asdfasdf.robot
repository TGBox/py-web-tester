*** Settings ***
Documentation    Automated test execution suite for recorded routine 'asdfasdf'.
Resource         ../resources/common.resource
Resource         ../resources/page_objects/asdfasdf.resource
Test Setup       Setup Web Test Browser    ${ASDFASDF_START_URL}
Test Teardown    Teardown Web Test Browser

*** Test Cases ***
Verify Recorded Routine Block Asdfasdf
    [Documentation]    Runs recorded user interactions as a test block.
    [Tags]             routine    recorded
    Execute Routine Asdfasdf

