*** Settings ***
Documentation    Recorded test block routine for 'new test data login dr instanz'.
Library          Browser
Library          ../libraries/visual_hud.py

*** Variables ***
${NEW_TEST_DATA_LOGIN_DR_INSTANZ_START_URL}    https://dr.data-al.cloud
${ACTION_DELAY}                    150ms


*** Keywords ***
Execute Routine New Test Data Login Dr Instanz
    [Documentation]    Executes recorded interaction sequence for new test data login dr instanz.
    [Arguments]        ${url}=${NEW_TEST_DATA_LOGIN_DR_INSTANZ_START_URL}
    # Step 1: Navigate to 'https://dr.data-al.cloud/aldashboard/'
    Go To    https://dr.data-al.cloud/aldashboard/
    Sleep    ${ACTION_DELAY}
    # Step 2: Navigate to 'https://dr.data-al.cloud/aldashboard/login?returnUrl=%2Fhome'
    Go To    https://dr.data-al.cloud/aldashboard/login?returnUrl=%2Fhome
    Sleep    ${ACTION_DELAY}
    # Step 3: Navigate to 'https://dr.data-al.cloud/aldashboard/home'
    Go To    https://dr.data-al.cloud/aldashboard/home
    Sleep    ${ACTION_DELAY}
    # Step 4: Navigate to 'https://dr.data-al.cloud/users/'
    Go To    https://dr.data-al.cloud/users/
    Sleep    ${ACTION_DELAY}
    # Step 5: Navigate to 'https://dr.data-al.cloud/users/home'
    Go To    https://dr.data-al.cloud/users/home
    Sleep    ${ACTION_DELAY}
    # Step 6: Navigate to 'https://dr.data-al.cloud/patienten/'
    Go To    https://dr.data-al.cloud/patienten/
    Sleep    ${ACTION_DELAY}
    # Step 7: Navigate to 'https://dr.data-al.cloud/patienten/patientenstamm'
    Go To    https://dr.data-al.cloud/patienten/patientenstamm
    Sleep    ${ACTION_DELAY}
    # Step 8: Navigate to 'https://dr.data-al.cloud/terminplaner/'
    Go To    https://dr.data-al.cloud/terminplaner/
    Sleep    ${ACTION_DELAY}
    # Step 9: Navigate to 'https://dr.data-al.cloud/terminplaner/event'
    Go To    https://dr.data-al.cloud/terminplaner/event
    Sleep    ${ACTION_DELAY}
    # Step 10: Navigate to 'https://dr.data-al.cloud/users/'
    Go To    https://dr.data-al.cloud/users/
    Sleep    ${ACTION_DELAY}
    # Step 11: Navigate to 'https://dr.data-al.cloud/users/home'
    Go To    https://dr.data-al.cloud/users/home
    Sleep    ${ACTION_DELAY}
