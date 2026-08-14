*** Settings ***
Documentation    Recorded test block routine for 'test'.
Library          Browser
Library          ../libraries/visual_hud.py

*** Variables ***
${TEST_START_URL}    https://dr.data-al.cloud
${ACTION_DELAY}                    150ms


*** Keywords ***
Execute Routine Test
    [Documentation]    Executes recorded interaction sequence for test.
    [Arguments]        ${url}=${TEST_START_URL}
    Log    No interactive steps recorded.
