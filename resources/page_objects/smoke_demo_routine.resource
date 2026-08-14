*** Settings ***
Documentation    Recorded test block routine for 'smoke_demo_routine'.
Library          Browser
Library          ../libraries/visual_hud.py

*** Variables ***
${SMOKE_DEMO_ROUTINE_START_URL}    https://example.com
${ACTION_DELAY}                    150ms


*** Keywords ***
Execute Routine Smoke Demo Routine
    [Documentation]    Executes recorded interaction sequence for smoke_demo_routine.
    [Arguments]        ${url}=${SMOKE_DEMO_ROUTINE_START_URL}
    Log    No interactive steps recorded.
