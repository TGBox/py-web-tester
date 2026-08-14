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
    # Step 1: Navigate to 'https://dr.data-al.cloud/aldashboard/'
    Go To    https://dr.data-al.cloud/aldashboard/
    Sleep    ${ACTION_DELAY}
    # Step 2: Navigate to 'https://dr.data-al.cloud/aldashboard/login?returnUrl=%2Fhome'
    Go To    https://dr.data-al.cloud/aldashboard/login?returnUrl=%2Fhome
    Sleep    ${ACTION_DELAY}
    # Step 3: Navigate to 'https://dr.data-al.cloud/aldashboard/home'
    Go To    https://dr.data-al.cloud/aldashboard/home
    Sleep    ${ACTION_DELAY}
    # Step 4: Navigate to 'https://dr.data-al.cloud/patienten/'
    Go To    https://dr.data-al.cloud/patienten/
    Sleep    ${ACTION_DELAY}
    # Step 5: Navigate to 'https://dr.data-al.cloud/patienten/patientenstamm'
    Go To    https://dr.data-al.cloud/patienten/patientenstamm
    Sleep    ${ACTION_DELAY}
    # Step 6: Navigate to 'https://dr.data-al.cloud/patienten/login'
    Go To    https://dr.data-al.cloud/patienten/login
    Sleep    ${ACTION_DELAY}
