*** Settings ***
Documentation    Automated test execution suite for recorded routine 'new test data login dr instanz'.
Resource         ../resources/common.resource
Resource         ../resources/page_objects/new test data login dr instanz.resource
Test Setup       Setup Web Test Browser
Test Teardown    Teardown Web Test Browser

*** Test Cases ***
Verify Recorded Routine Block New Test Data Login Dr Instanz
    [Documentation]    Runs recorded user interactions as a test block.
    [Tags]             routine    recorded
    Execute Routine New Test Data Login Dr Instanz

