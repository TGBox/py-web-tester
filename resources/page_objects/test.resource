*** Settings ***
Documentation    Recorded test block routine for 'test'.
Library          Browser

*** Variables ***
${TEST_START_URL}    https://dr.data-al.cloud


*** Keywords ***
Execute Routine Test
    [Documentation]    Executes recorded interaction sequence for test.
    [Arguments]        ${url}=${TEST_START_URL}
    Log    No interactive steps recorded.
