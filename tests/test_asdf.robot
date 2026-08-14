*** Settings ***
Documentation    Automated test execution suite for recorded routine 'asdf'.
Resource         ../resources/common.resource
Resource         ../resources/page_objects/asdf.resource
Test Setup       Setup Web Test Browser    ${ASDF_START_URL}
Test Teardown    Teardown Web Test Browser

*** Test Cases ***
Verify Recorded Routine Block Asdf
    [Documentation]    Runs recorded user interactions as a test block.
    [Tags]             routine    recorded
    Execute Routine Asdf

