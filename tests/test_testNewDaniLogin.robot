*** Settings ***
Documentation    Automated test execution suite for recorded routine 'testNewDaniLogin'.
Resource         ../resources/common.resource
Resource         ../resources/page_objects/testNewDaniLogin.resource
Test Setup       Setup Web Test Browser
Test Teardown    Teardown Web Test Browser

*** Test Cases ***
Verify Recorded Routine Block Testnewdanilogin
    [Documentation]    Runs recorded user interactions as a test block.
    [Tags]             routine    recorded
    Execute Routine Testnewdanilogin

