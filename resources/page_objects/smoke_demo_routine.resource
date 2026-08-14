*** Settings ***
Documentation    Recorded test block routine for 'smoke_demo_routine'.
Library          Browser

*** Variables ***
${SMOKE_DEMO_ROUTINE_START_URL}    https://example.com


*** Keywords ***
Execute Routine Smoke Demo Routine
    [Documentation]    Executes recorded interaction sequence for smoke_demo_routine.
    [Arguments]        ${url}=${SMOKE_DEMO_ROUTINE_START_URL}
    Log    No interactive steps recorded.
