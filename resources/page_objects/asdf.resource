*** Settings ***
Documentation    Recorded test block routine for 'asdf'.
Library          Browser
Library          ../libraries/visual_hud.py

*** Variables ***
${ASDF_START_URL}    https://dr.data-al.cloud
${ACTION_DELAY}                    150ms


*** Keywords ***
Execute Routine Asdf
    [Documentation]    Executes recorded interaction sequence for asdf.
    [Arguments]        ${url}=${ASDF_START_URL}
    # Step 1: Navigate to 'https://dr.data-al.cloud/aldashboard/'
    Go To    https://dr.data-al.cloud/aldashboard/
    Sleep    ${ACTION_DELAY}
