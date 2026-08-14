*** Settings ***
Documentation    Recorded test block routine for 'termin erstellen'.
Library          Browser
Library          ../libraries/visual_hud.py

*** Variables ***
${TERMIN_ERSTELLEN_START_URL}    https://dr.data-al.cloud
${ACTION_DELAY}                    150ms


*** Keywords ***
Execute Routine Termin Erstellen
    [Documentation]    Executes recorded interaction sequence for termin erstellen.
    [Arguments]        ${url}=${TERMIN_ERSTELLEN_START_URL}
    # Step 1: Navigate to 'https://dr.data-al.cloud/aldashboard/'
    Go To    https://dr.data-al.cloud/aldashboard/
    Sleep    ${ACTION_DELAY}
    # Step 2: Navigate to 'https://dr.data-al.cloud/aldashboard/login?returnUrl=%2Fhome'
    Go To    https://dr.data-al.cloud/aldashboard/login?returnUrl=%2Fhome
    Sleep    ${ACTION_DELAY}
    # Step 3: Navigate to 'https://dr.data-al.cloud/aldashboard/home'
    Go To    https://dr.data-al.cloud/aldashboard/home
    Sleep    ${ACTION_DELAY}
    # Step 4: Navigate to 'https://dr.data-al.cloud/terminplaner/'
    Go To    https://dr.data-al.cloud/terminplaner/
    Sleep    ${ACTION_DELAY}
    # Step 5: Navigate to 'https://dr.data-al.cloud/terminplaner/event'
    Go To    https://dr.data-al.cloud/terminplaner/event
    Sleep    ${ACTION_DELAY}
    # Step 6: Navigate to 'https://dr.data-al.cloud/patienten/'
    Go To    https://dr.data-al.cloud/patienten/
    Sleep    ${ACTION_DELAY}
    # Step 7: Navigate to 'https://dr.data-al.cloud/patienten/patientenstamm'
    Go To    https://dr.data-al.cloud/patienten/patientenstamm
    Sleep    ${ACTION_DELAY}
    # Step 8: Navigate to 'https://dr.data-al.cloud/patienten/patientenkontaktliste'
    Go To    https://dr.data-al.cloud/patienten/patientenkontaktliste
    Sleep    ${ACTION_DELAY}
    # Step 9: Navigate to 'https://dr.data-al.cloud/patienten/patientenstamm'
    Go To    https://dr.data-al.cloud/patienten/patientenstamm
    Sleep    ${ACTION_DELAY}
    # Step 10: Navigate to 'https://dr.data-al.cloud/patienten/patientenstamm/MST4PMPX-8M5AI'
    Go To    https://dr.data-al.cloud/patienten/patientenstamm/MST4PMPX-8M5AI
    Sleep    ${ACTION_DELAY}
    # Step 11: Navigate to 'https://dr.data-al.cloud/terminplaner/event?patientid=MST4PMPX-8M5AI'
    Go To    https://dr.data-al.cloud/terminplaner/event?patientid=MST4PMPX-8M5AI
    Sleep    ${ACTION_DELAY}
    # Step 12: Navigate to 'https://dr.data-al.cloud/patienten/patientenstamm/MST4PMPX-8M5AI'
    Go To    https://dr.data-al.cloud/patienten/patientenstamm/MST4PMPX-8M5AI
    Sleep    ${ACTION_DELAY}
