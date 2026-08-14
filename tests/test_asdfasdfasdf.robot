*** Settings ***
Documentation    Automated test execution suite for recorded routine 'asdfasdfasdf'.
Resource         ../resources/common.resource
Resource         ../resources/page_objects/asdfasdfasdf.resource
Test Setup       Setup Web Test Browser    ${ASDFASDFASDF_START_URL}
Test Teardown    Teardown Web Test Browser

*** Test Cases ***
Verify Recorded Routine Block Asdfasdfasdf
    [Documentation]    Runs recorded user interactions as a test block.
    [Tags]             routine    recorded
    Execute Routine Asdfasdfasdf

