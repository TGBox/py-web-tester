*** Settings ***
Documentation    Automated test execution suite for recorded routine 'Login und Logout'.
Resource         ../resources/common.resource
Resource         ../resources/page_objects/Login und Logout.resource
Test Setup       Setup Web Test Browser    ${LOGIN_UND_LOGOUT_START_URL}
Test Teardown    Teardown Web Test Browser

*** Test Cases ***
Verify Recorded Routine Block Login Und Logout
    [Documentation]    Runs recorded user interactions as a test block.
    [Tags]             routine    recorded
    Execute Routine Login Und Logout

