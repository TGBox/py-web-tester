*** Settings ***
Documentation    Automated test execution suite for recorded routine 'Login - Termininteraktionen - Logout'.
Resource         ../resources/common.resource
Resource         ../resources/page_objects/Login - Termininteraktionen - Logout.resource
Test Setup       Setup Web Test Browser    ${LOGIN___TERMININTERAKTIONEN___LOGOUT_START_URL}
Test Teardown    Teardown Web Test Browser

*** Test Cases ***
Verify Recorded Routine Block Login   Termininteraktionen   Logout
    [Documentation]    Runs recorded user interactions as a test block.
    [Tags]             routine    recorded
    Execute Routine Login   Termininteraktionen   Logout

