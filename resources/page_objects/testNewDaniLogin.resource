*** Settings ***
Documentation    Recorded test block routine for 'testNewDaniLogin'.
Library          Browser

*** Variables ***
${TESTNEWDANILOGIN_START_URL}    https://dr.data-al.cloud

${SELECTOR_TESTNEWDANILOGIN_1}      div.mat-form-field-infix.ng-tns-c51-1
${SELECTOR_TESTNEWDANILOGIN_2}      app-login.ng-star-inserted
${SELECTOR_TESTNEWDANILOGIN_3}      #mat-input-0
${SELECTOR_TESTNEWDANILOGIN_4}      #mat-input-1
${SELECTOR_TESTNEWDANILOGIN_5}      mat-icon[role="img"]
${SELECTOR_TESTNEWDANILOGIN_6}      button:has-text("check")
${SELECTOR_TESTNEWDANILOGIN_7}      app-root > mat-sidenav-container > mat-sidenav-content > div > div:nth-of-type(2) > app-karteidefinition > div > div > div > button > span
${SELECTOR_TESTNEWDANILOGIN_8}      app-root > mat-sidenav-container > mat-sidenav-content > div > div > button > span > img
${SELECTOR_TESTNEWDANILOGIN_9}      button[aria-label="Toggle sidenav"]
${SELECTOR_TESTNEWDANILOGIN_10}     span:has-text("people Patientenstamm")
${SELECTOR_TESTNEWDANILOGIN_11}     input[role="combobox"]
${SELECTOR_TESTNEWDANILOGIN_12}     button:has-text("dashboard")
${SELECTOR_TESTNEWDANILOGIN_13}     span:has-text("calendar_month
Terminplaner")
${SELECTOR_TESTNEWDANILOGIN_14}     mat-toolbar.mat-toolbar.ng-tns-c105-0
${SELECTOR_TESTNEWDANILOGIN_15}     mat-sidenav[role="navigation"]
${SELECTOR_TESTNEWDANILOGIN_16}     button:has-text("settings")
${SELECTOR_TESTNEWDANILOGIN_17}     span:has-text("Administrator")
${SELECTOR_TESTNEWDANILOGIN_18}     a:has-text("Logout Administrator")

*** Keywords ***
Execute Routine Testnewdanilogin
    [Documentation]    Executes recorded interaction sequence for testNewDaniLogin.
    [Arguments]        ${url}=${TESTNEWDANILOGIN_START_URL}
    # Step 1: Navigate to 'https://dr.data-al.cloud/aldashboard/'
    Go To    https://dr.data-al.cloud/aldashboard/
    Sleep    200ms
    # Step 2: Navigate to 'https://dr.data-al.cloud/aldashboard/login?returnUrl=%2Fhome'
    Go To    https://dr.data-al.cloud/aldashboard/login?returnUrl=%2Fhome
    Sleep    200ms
    # Step 3: Click element 'E-Mail *'
    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_1}    visible    timeout=10s
    Click    ${SELECTOR_TESTNEWDANILOGIN_1}
    Sleep    200ms
    # Step 4: Click element 'Anmelden
E-Mail *
Passwort *
check'
    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_2}    visible    timeout=10s
    Click    ${SELECTOR_TESTNEWDANILOGIN_2}
    Sleep    200ms
    # Step 5: Fill input field '#mat-input-0'
    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_3}    visible    timeout=10s
    Fill Text    ${SELECTOR_TESTNEWDANILOGIN_3}    
    Sleep    200ms
    # Step 6: Click element 'INPUT'
    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_3}    visible    timeout=10s
    Click    ${SELECTOR_TESTNEWDANILOGIN_3}
    Sleep    200ms
    # Step 7: Fill input field '#mat-input-0'
    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_3}    visible    timeout=10s
    Fill Text    ${SELECTOR_TESTNEWDANILOGIN_3}    admin@demo.de
    Sleep    200ms
    # Step 8: Click element 'Anmelden
E-Mail *
Passwort *
check'
    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_2}    visible    timeout=10s
    Click    ${SELECTOR_TESTNEWDANILOGIN_2}
    Sleep    200ms
    # Step 9: Fill input field '#mat-input-1'
    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_4}    visible    timeout=10s
    Fill Text    ${SELECTOR_TESTNEWDANILOGIN_4}    admin
    Sleep    200ms
    # Step 10: Click element 'check'
    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_5}    visible    timeout=10s
    Click    ${SELECTOR_TESTNEWDANILOGIN_5}
    Sleep    200ms
    # Step 11: Fill input field 'button:has-text("check")'
    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_6}    visible    timeout=10s
    Fill Text    ${SELECTOR_TESTNEWDANILOGIN_6}    
    Sleep    200ms
    # Step 12: Navigate to 'https://dr.data-al.cloud/aldashboard/home'
    Go To    https://dr.data-al.cloud/aldashboard/home
    Sleep    200ms
    # Step 13: Click element 'settings Benutzer und Einstellungen'
    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_7}    visible    timeout=10s
    Click    ${SELECTOR_TESTNEWDANILOGIN_7}
    Sleep    200ms
    # Step 14: Navigate to 'https://dr.data-al.cloud/users/'
    Go To    https://dr.data-al.cloud/users/
    Sleep    200ms
    # Step 15: Navigate to 'https://dr.data-al.cloud/users/home'
    Go To    https://dr.data-al.cloud/users/home
    Sleep    200ms
    # Step 16: Click element 'IMG'
    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_8}    visible    timeout=10s
    Click    ${SELECTOR_TESTNEWDANILOGIN_8}
    Sleep    200ms
    # Step 17: Fill input field 'button[aria-label="Toggle sidenav"]'
    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_9}    visible    timeout=10s
    Fill Text    ${SELECTOR_TESTNEWDANILOGIN_9}    
    Sleep    200ms
    # Step 18: Click element 'dashboard'
    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_5}    visible    timeout=10s
    Click    ${SELECTOR_TESTNEWDANILOGIN_5}
    Sleep    200ms
    # Step 19: Navigate to 'https://dr.data-al.cloud/aldashboard/'
    Go To    https://dr.data-al.cloud/aldashboard/
    Sleep    200ms
    # Step 20: Navigate to 'https://dr.data-al.cloud/aldashboard/home'
    Go To    https://dr.data-al.cloud/aldashboard/home
    Sleep    200ms
    # Step 21: Click element 'people Patientenstamm'
    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_10}    visible    timeout=10s
    Click    ${SELECTOR_TESTNEWDANILOGIN_10}
    Sleep    200ms
    # Step 22: Navigate to 'https://dr.data-al.cloud/patienten/'
    Go To    https://dr.data-al.cloud/patienten/
    Sleep    200ms
    # Step 23: Navigate to 'https://dr.data-al.cloud/patienten/patientenstamm'
    Go To    https://dr.data-al.cloud/patienten/patientenstamm
    Sleep    200ms
    # Step 24: Fill input field 'input[role="combobox"]'
    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_11}    visible    timeout=10s
    Fill Text    ${SELECTOR_TESTNEWDANILOGIN_11}    
    Sleep    200ms
    # Step 25: Click element 'IMG'
    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_8}    visible    timeout=10s
    Click    ${SELECTOR_TESTNEWDANILOGIN_8}
    Sleep    200ms
    # Step 26: Fill input field 'button[aria-label="Toggle sidenav"]'
    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_9}    visible    timeout=10s
    Fill Text    ${SELECTOR_TESTNEWDANILOGIN_9}    
    Sleep    200ms
    # Step 27: Click element 'dashboard'
    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_12}    visible    timeout=10s
    Click    ${SELECTOR_TESTNEWDANILOGIN_12}
    Sleep    200ms
    # Step 28: Navigate to 'https://dr.data-al.cloud/aldashboard/'
    Go To    https://dr.data-al.cloud/aldashboard/
    Sleep    200ms
    # Step 29: Navigate to 'https://dr.data-al.cloud/aldashboard/home'
    Go To    https://dr.data-al.cloud/aldashboard/home
    Sleep    200ms
    # Step 30: Click element 'calendar_month
Terminplaner'
    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_13}    visible    timeout=10s
    Click    ${SELECTOR_TESTNEWDANILOGIN_13}
    Sleep    200ms
    # Step 31: Navigate to 'https://dr.data-al.cloud/terminplaner/'
    Go To    https://dr.data-al.cloud/terminplaner/
    Sleep    200ms
    # Step 32: Navigate to 'https://dr.data-al.cloud/terminplaner/event'
    Go To    https://dr.data-al.cloud/terminplaner/event
    Sleep    200ms
    # Step 33: Click element 'IMG'
    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_8}    visible    timeout=10s
    Click    ${SELECTOR_TESTNEWDANILOGIN_8}
    Sleep    200ms
    # Step 34: Fill input field 'button[aria-label="Toggle sidenav"]'
    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_9}    visible    timeout=10s
    Fill Text    ${SELECTOR_TESTNEWDANILOGIN_9}    
    Sleep    200ms
    # Step 35: Click element 'dashboard'
    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_5}    visible    timeout=10s
    Click    ${SELECTOR_TESTNEWDANILOGIN_5}
    Sleep    200ms
    # Step 36: Navigate to 'https://dr.data-al.cloud/aldashboard/'
    Go To    https://dr.data-al.cloud/aldashboard/
    Sleep    200ms
    # Step 37: Navigate to 'https://dr.data-al.cloud/aldashboard/home'
    Go To    https://dr.data-al.cloud/aldashboard/home
    Sleep    200ms
    # Step 38: Click element 'IMG'
    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_8}    visible    timeout=10s
    Click    ${SELECTOR_TESTNEWDANILOGIN_8}
    Sleep    200ms
    # Step 39: Fill input field 'button[aria-label="Toggle sidenav"]'
    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_9}    visible    timeout=10s
    Fill Text    ${SELECTOR_TESTNEWDANILOGIN_9}    
    Sleep    200ms
    # Step 40: Click element 'settings'
    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_5}    visible    timeout=10s
    Click    ${SELECTOR_TESTNEWDANILOGIN_5}
    Sleep    200ms
    # Step 41: Navigate to 'https://dr.data-al.cloud/users/'
    Go To    https://dr.data-al.cloud/users/
    Sleep    200ms
    # Step 42: Navigate to 'https://dr.data-al.cloud/users/home'
    Go To    https://dr.data-al.cloud/users/home
    Sleep    200ms
    # Step 43: Click element 'IMG'
    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_8}    visible    timeout=10s
    Click    ${SELECTOR_TESTNEWDANILOGIN_8}
    Sleep    200ms
    # Step 44: Fill input field 'button[aria-label="Toggle sidenav"]'
    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_9}    visible    timeout=10s
    Fill Text    ${SELECTOR_TESTNEWDANILOGIN_9}    
    Sleep    200ms
    # Step 45: Fill input field 'button:has-text("dashboard")'
    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_12}    visible    timeout=10s
    Fill Text    ${SELECTOR_TESTNEWDANILOGIN_12}    
    Sleep    200ms
    # Step 46: Click element 'people'
    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_5}    visible    timeout=10s
    Click    ${SELECTOR_TESTNEWDANILOGIN_5}
    Sleep    200ms
    # Step 47: Navigate to 'https://dr.data-al.cloud/patienten/'
    Go To    https://dr.data-al.cloud/patienten/
    Sleep    200ms
    # Step 48: Navigate to 'https://dr.data-al.cloud/patienten/patientenstamm'
    Go To    https://dr.data-al.cloud/patienten/patientenstamm
    Sleep    200ms
    # Step 49: Fill input field 'input[role="combobox"]'
    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_11}    visible    timeout=10s
    Fill Text    ${SELECTOR_TESTNEWDANILOGIN_11}    
    Sleep    200ms
    # Step 50: Click element 'IMG'
    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_8}    visible    timeout=10s
    Click    ${SELECTOR_TESTNEWDANILOGIN_8}
    Sleep    200ms
    # Step 51: Fill input field 'button[aria-label="Toggle sidenav"]'
    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_9}    visible    timeout=10s
    Fill Text    ${SELECTOR_TESTNEWDANILOGIN_9}    
    Sleep    200ms
    # Step 52: Fill input field 'button:has-text("dashboard")'
    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_12}    visible    timeout=10s
    Fill Text    ${SELECTOR_TESTNEWDANILOGIN_12}    
    Sleep    200ms
    # Step 53: Click element 'calendar_month'
    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_5}    visible    timeout=10s
    Click    ${SELECTOR_TESTNEWDANILOGIN_5}
    Sleep    200ms
    # Step 54: Navigate to 'https://dr.data-al.cloud/terminplaner/'
    Go To    https://dr.data-al.cloud/terminplaner/
    Sleep    200ms
    # Step 55: Navigate to 'https://dr.data-al.cloud/terminplaner/event'
    Go To    https://dr.data-al.cloud/terminplaner/event
    Sleep    200ms
    # Step 56: Click element 'IMG'
    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_8}    visible    timeout=10s
    Click    ${SELECTOR_TESTNEWDANILOGIN_8}
    Sleep    200ms
    # Step 57: Fill input field 'button[aria-label="Toggle sidenav"]'
    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_9}    visible    timeout=10s
    Fill Text    ${SELECTOR_TESTNEWDANILOGIN_9}    
    Sleep    200ms
    # Step 58: Fill input field 'button:has-text("dashboard")'
    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_12}    visible    timeout=10s
    Fill Text    ${SELECTOR_TESTNEWDANILOGIN_12}    
    Sleep    200ms
    # Step 59: Click element 'settings'
    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_5}    visible    timeout=10s
    Click    ${SELECTOR_TESTNEWDANILOGIN_5}
    Sleep    200ms
    # Step 60: Navigate to 'https://dr.data-al.cloud/users/'
    Go To    https://dr.data-al.cloud/users/
    Sleep    200ms
    # Step 61: Navigate to 'https://dr.data-al.cloud/users/home'
    Go To    https://dr.data-al.cloud/users/home
    Sleep    200ms
    # Step 62: Click element 'IMG'
    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_8}    visible    timeout=10s
    Click    ${SELECTOR_TESTNEWDANILOGIN_8}
    Sleep    200ms
    # Step 63: Fill input field 'button[aria-label="Toggle sidenav"]'
    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_9}    visible    timeout=10s
    Fill Text    ${SELECTOR_TESTNEWDANILOGIN_9}    
    Sleep    200ms
    # Step 64: Fill input field 'button:has-text("dashboard")'
    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_12}    visible    timeout=10s
    Fill Text    ${SELECTOR_TESTNEWDANILOGIN_12}    
    Sleep    200ms
    # Step 65: Click element 'dashboard
settings
people
calendar_month'
    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_14}    visible    timeout=10s
    Click    ${SELECTOR_TESTNEWDANILOGIN_14}
    Sleep    200ms
    # Step 66: Fill input field 'mat-sidenav[role="navigation"]'
    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_15}    visible    timeout=10s
    Fill Text    ${SELECTOR_TESTNEWDANILOGIN_15}    
    Sleep    200ms
    # Step 67: Click element 'dashboard'
    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_5}    visible    timeout=10s
    Click    ${SELECTOR_TESTNEWDANILOGIN_5}
    Sleep    200ms
    # Step 68: Navigate to 'https://dr.data-al.cloud/aldashboard/'
    Go To    https://dr.data-al.cloud/aldashboard/
    Sleep    200ms
    # Step 69: Navigate to 'https://dr.data-al.cloud/aldashboard/home'
    Go To    https://dr.data-al.cloud/aldashboard/home
    Sleep    200ms
    # Step 70: Click element 'IMG'
    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_8}    visible    timeout=10s
    Click    ${SELECTOR_TESTNEWDANILOGIN_8}
    Sleep    200ms
    # Step 71: Fill input field 'button[aria-label="Toggle sidenav"]'
    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_9}    visible    timeout=10s
    Fill Text    ${SELECTOR_TESTNEWDANILOGIN_9}    
    Sleep    200ms
    # Step 72: Fill input field 'button:has-text("settings")'
    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_16}    visible    timeout=10s
    Fill Text    ${SELECTOR_TESTNEWDANILOGIN_16}    
    Sleep    200ms
    # Step 73: Click element 'Administrator'
    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_17}    visible    timeout=10s
    Click    ${SELECTOR_TESTNEWDANILOGIN_17}
    Sleep    200ms
    # Step 74: Fill input field 'a:has-text("Logout Administrator")'
    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_18}    visible    timeout=10s
    Fill Text    ${SELECTOR_TESTNEWDANILOGIN_18}    
    Sleep    200ms
    # Step 75: Navigate to 'https://dr.data-al.cloud/aldashboard/login'
    Go To    https://dr.data-al.cloud/aldashboard/login
    Sleep    200ms
    # Step 76: Fill input field 'button[aria-label="Toggle sidenav"]'
    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_9}    visible    timeout=10s
    Fill Text    ${SELECTOR_TESTNEWDANILOGIN_9}    
    Sleep    200ms
