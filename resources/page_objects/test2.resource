*** Settings ***
Documentation    Recorded test block routine for 'test2'.
Library          Browser
Library          ../libraries/visual_hud.py

*** Variables ***
${TEST2_START_URL}    https://dr.data-al.cloud
${ACTION_DELAY}                    150ms


*** Keywords ***
Execute Routine Test2
    [Documentation]    Executes recorded interaction sequence for test2.
    [Arguments]        ${url}=${TEST2_START_URL}
    # Step 1: Navigate to 'https://dr.data-al.cloud/aldashboard/'
    Go To    https://dr.data-al.cloud/aldashboard/
    Sleep    ${ACTION_DELAY}
