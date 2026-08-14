*** Settings ***
Documentation    Recorded test block routine for 'asdfasdf'.
Library          Browser
Library          ../libraries/visual_hud.py

*** Variables ***
${ASDFASDF_START_URL}    https://dr.data-al.cloud
${ACTION_DELAY}                    150ms


*** Keywords ***
Execute Routine Asdfasdf
    [Documentation]    Executes recorded interaction sequence for asdfasdf.
    [Arguments]        ${url}=${ASDFASDF_START_URL}
    # Step 1: Navigate to 'https://dr.data-al.cloud/aldashboard/'
    Go To    https://dr.data-al.cloud/aldashboard/
    Sleep    ${ACTION_DELAY}
