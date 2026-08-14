*** Settings ***
Documentation    Automated test execution suite for recorded routine 'zuzturztu'.
Resource         ../resources/common.resource
Resource         ../resources/page_objects/zuzturztu.resource
Test Setup       Setup Web Test Browser    ${ZUZTURZTU_START_URL}
Test Teardown    Teardown Web Test Browser

*** Test Cases ***
Verify Recorded Routine Block Zuzturztu
    [Documentation]    Runs recorded user interactions as a test block.
    [Tags]             routine    recorded
    Execute Routine Zuzturztu

