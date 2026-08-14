*** Settings ***
Documentation    Automated test execution suite for recorded routine 'DataCur-Login-Instanz-DR'.
Resource         ../resources/common.resource
Resource         ../resources/page_objects/DataCur-Login-Instanz-DR.resource
Test Setup       Setup Web Test Browser
Test Teardown    Teardown Web Test Browser

*** Test Cases ***
Verify Recorded Routine Block Datacur Login Instanz Dr
    [Documentation]    Runs recorded user interactions as a test block.
    [Tags]             routine    recorded
    Execute Routine Datacur Login Instanz Dr

