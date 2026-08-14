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
${SELECTOR_TESTNEWDANILOGIN_13}     span:has-text("calendar_month Terminplaner")
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
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_1}    visible    timeout=3s
    IF    ${is_visible}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTNEWDANILOGIN_1}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTNEWDANILOGIN_1}    force=True
        END
    END
    Sleep    200ms
    # Step 4: Click element 'Anmelden E-Mail * Passwort * check'
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_2}    visible    timeout=3s
    IF    ${is_visible}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTNEWDANILOGIN_2}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTNEWDANILOGIN_2}    force=True
        END
    END
    Sleep    200ms
    # Step 5: Fill input field '#mat-input-0'
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_3}    visible    timeout=3s
    IF    ${is_visible}
        Fill Text    ${SELECTOR_TESTNEWDANILOGIN_3}    
    END
    Sleep    200ms
    # Step 6: Click element 'INPUT'
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_3}    visible    timeout=3s
    IF    ${is_visible}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTNEWDANILOGIN_3}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTNEWDANILOGIN_3}    force=True
        END
    END
    Sleep    200ms
    # Step 7: Fill input field '#mat-input-0'
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_3}    visible    timeout=3s
    IF    ${is_visible}
        Fill Text    ${SELECTOR_TESTNEWDANILOGIN_3}    admin@demo.de
    END
    Sleep    200ms
    # Step 8: Click element 'Anmelden E-Mail * Passwort * check'
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_2}    visible    timeout=3s
    IF    ${is_visible}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTNEWDANILOGIN_2}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTNEWDANILOGIN_2}    force=True
        END
    END
    Sleep    200ms
    # Step 9: Fill input field '#mat-input-1'
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_4}    visible    timeout=3s
    IF    ${is_visible}
        Fill Text    ${SELECTOR_TESTNEWDANILOGIN_4}    admin
    END
    Sleep    200ms
    # Step 10: Click element 'check'
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_5}    visible    timeout=3s
    IF    ${is_visible}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTNEWDANILOGIN_5}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTNEWDANILOGIN_5}    force=True
        END
    END
    Sleep    200ms
    # Step 11: Click element 'check'
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_6}    visible    timeout=3s
    IF    ${is_visible}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTNEWDANILOGIN_6}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTNEWDANILOGIN_6}    force=True
        END
    END
    Sleep    200ms
    # Step 12: Navigate to 'https://dr.data-al.cloud/aldashboard/home'
    Go To    https://dr.data-al.cloud/aldashboard/home
    Sleep    200ms
    # Step 13: Click element 'settings Benutzer und Einstellungen'
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_7}    visible    timeout=3s
    IF    ${is_visible}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTNEWDANILOGIN_7}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTNEWDANILOGIN_7}    force=True
        END
    END
    Sleep    200ms
    # Step 14: Navigate to 'https://dr.data-al.cloud/users/'
    Go To    https://dr.data-al.cloud/users/
    Sleep    200ms
    # Step 15: Navigate to 'https://dr.data-al.cloud/users/home'
    Go To    https://dr.data-al.cloud/users/home
    Sleep    200ms
    # Step 16: Click element 'IMG'
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_8}    visible    timeout=3s
    IF    ${is_visible}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTNEWDANILOGIN_8}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTNEWDANILOGIN_8}    force=True
        END
    END
    Sleep    200ms
    # Step 17: Click element 'BUTTON'
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_9}    visible    timeout=3s
    IF    ${is_visible}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTNEWDANILOGIN_9}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTNEWDANILOGIN_9}    force=True
        END
    END
    Sleep    200ms
    # Step 18: Click element 'dashboard'
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_5}    visible    timeout=3s
    IF    ${is_visible}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTNEWDANILOGIN_5}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTNEWDANILOGIN_5}    force=True
        END
    END
    Sleep    200ms
    # Step 19: Navigate to 'https://dr.data-al.cloud/aldashboard/'
    Go To    https://dr.data-al.cloud/aldashboard/
    Sleep    200ms
    # Step 20: Navigate to 'https://dr.data-al.cloud/aldashboard/home'
    Go To    https://dr.data-al.cloud/aldashboard/home
    Sleep    200ms
    # Step 21: Click element 'people Patientenstamm'
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_10}    visible    timeout=3s
    IF    ${is_visible}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTNEWDANILOGIN_10}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTNEWDANILOGIN_10}    force=True
        END
    END
    Sleep    200ms
    # Step 22: Navigate to 'https://dr.data-al.cloud/patienten/'
    Go To    https://dr.data-al.cloud/patienten/
    Sleep    200ms
    # Step 23: Navigate to 'https://dr.data-al.cloud/patienten/patientenstamm'
    Go To    https://dr.data-al.cloud/patienten/patientenstamm
    Sleep    200ms
    # Step 24: Fill input field 'input[role="combobox"]'
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_11}    visible    timeout=3s
    IF    ${is_visible}
        Fill Text    ${SELECTOR_TESTNEWDANILOGIN_11}    
    END
    Sleep    200ms
    # Step 25: Click element 'IMG'
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_8}    visible    timeout=3s
    IF    ${is_visible}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTNEWDANILOGIN_8}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTNEWDANILOGIN_8}    force=True
        END
    END
    Sleep    200ms
    # Step 26: Click element 'BUTTON'
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_9}    visible    timeout=3s
    IF    ${is_visible}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTNEWDANILOGIN_9}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTNEWDANILOGIN_9}    force=True
        END
    END
    Sleep    200ms
    # Step 27: Click element 'dashboard'
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_12}    visible    timeout=3s
    IF    ${is_visible}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTNEWDANILOGIN_12}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTNEWDANILOGIN_12}    force=True
        END
    END
    Sleep    200ms
    # Step 28: Navigate to 'https://dr.data-al.cloud/aldashboard/'
    Go To    https://dr.data-al.cloud/aldashboard/
    Sleep    200ms
    # Step 29: Navigate to 'https://dr.data-al.cloud/aldashboard/home'
    Go To    https://dr.data-al.cloud/aldashboard/home
    Sleep    200ms
    # Step 30: Click element 'calendar_month Terminplaner'
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_13}    visible    timeout=3s
    IF    ${is_visible}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTNEWDANILOGIN_13}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTNEWDANILOGIN_13}    force=True
        END
    END
    Sleep    200ms
    # Step 31: Navigate to 'https://dr.data-al.cloud/terminplaner/'
    Go To    https://dr.data-al.cloud/terminplaner/
    Sleep    200ms
    # Step 32: Navigate to 'https://dr.data-al.cloud/terminplaner/event'
    Go To    https://dr.data-al.cloud/terminplaner/event
    Sleep    200ms
    # Step 33: Click element 'IMG'
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_8}    visible    timeout=3s
    IF    ${is_visible}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTNEWDANILOGIN_8}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTNEWDANILOGIN_8}    force=True
        END
    END
    Sleep    200ms
    # Step 34: Click element 'BUTTON'
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_9}    visible    timeout=3s
    IF    ${is_visible}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTNEWDANILOGIN_9}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTNEWDANILOGIN_9}    force=True
        END
    END
    Sleep    200ms
    # Step 35: Click element 'dashboard'
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_5}    visible    timeout=3s
    IF    ${is_visible}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTNEWDANILOGIN_5}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTNEWDANILOGIN_5}    force=True
        END
    END
    Sleep    200ms
    # Step 36: Navigate to 'https://dr.data-al.cloud/aldashboard/'
    Go To    https://dr.data-al.cloud/aldashboard/
    Sleep    200ms
    # Step 37: Navigate to 'https://dr.data-al.cloud/aldashboard/home'
    Go To    https://dr.data-al.cloud/aldashboard/home
    Sleep    200ms
    # Step 38: Click element 'IMG'
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_8}    visible    timeout=3s
    IF    ${is_visible}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTNEWDANILOGIN_8}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTNEWDANILOGIN_8}    force=True
        END
    END
    Sleep    200ms
    # Step 39: Click element 'BUTTON'
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_9}    visible    timeout=3s
    IF    ${is_visible}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTNEWDANILOGIN_9}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTNEWDANILOGIN_9}    force=True
        END
    END
    Sleep    200ms
    # Step 40: Click element 'settings'
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_5}    visible    timeout=3s
    IF    ${is_visible}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTNEWDANILOGIN_5}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTNEWDANILOGIN_5}    force=True
        END
    END
    Sleep    200ms
    # Step 41: Navigate to 'https://dr.data-al.cloud/users/'
    Go To    https://dr.data-al.cloud/users/
    Sleep    200ms
    # Step 42: Navigate to 'https://dr.data-al.cloud/users/home'
    Go To    https://dr.data-al.cloud/users/home
    Sleep    200ms
    # Step 43: Click element 'IMG'
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_8}    visible    timeout=3s
    IF    ${is_visible}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTNEWDANILOGIN_8}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTNEWDANILOGIN_8}    force=True
        END
    END
    Sleep    200ms
    # Step 44: Click element 'BUTTON'
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_9}    visible    timeout=3s
    IF    ${is_visible}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTNEWDANILOGIN_9}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTNEWDANILOGIN_9}    force=True
        END
    END
    Sleep    200ms
    # Step 45: Click element 'dashboard'
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_12}    visible    timeout=3s
    IF    ${is_visible}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTNEWDANILOGIN_12}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTNEWDANILOGIN_12}    force=True
        END
    END
    Sleep    200ms
    # Step 46: Click element 'people'
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_5}    visible    timeout=3s
    IF    ${is_visible}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTNEWDANILOGIN_5}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTNEWDANILOGIN_5}    force=True
        END
    END
    Sleep    200ms
    # Step 47: Navigate to 'https://dr.data-al.cloud/patienten/'
    Go To    https://dr.data-al.cloud/patienten/
    Sleep    200ms
    # Step 48: Navigate to 'https://dr.data-al.cloud/patienten/patientenstamm'
    Go To    https://dr.data-al.cloud/patienten/patientenstamm
    Sleep    200ms
    # Step 49: Fill input field 'input[role="combobox"]'
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_11}    visible    timeout=3s
    IF    ${is_visible}
        Fill Text    ${SELECTOR_TESTNEWDANILOGIN_11}    
    END
    Sleep    200ms
    # Step 50: Click element 'IMG'
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_8}    visible    timeout=3s
    IF    ${is_visible}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTNEWDANILOGIN_8}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTNEWDANILOGIN_8}    force=True
        END
    END
    Sleep    200ms
    # Step 51: Click element 'BUTTON'
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_9}    visible    timeout=3s
    IF    ${is_visible}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTNEWDANILOGIN_9}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTNEWDANILOGIN_9}    force=True
        END
    END
    Sleep    200ms
    # Step 52: Click element 'dashboard'
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_12}    visible    timeout=3s
    IF    ${is_visible}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTNEWDANILOGIN_12}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTNEWDANILOGIN_12}    force=True
        END
    END
    Sleep    200ms
    # Step 53: Click element 'calendar_month'
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_5}    visible    timeout=3s
    IF    ${is_visible}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTNEWDANILOGIN_5}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTNEWDANILOGIN_5}    force=True
        END
    END
    Sleep    200ms
    # Step 54: Navigate to 'https://dr.data-al.cloud/terminplaner/'
    Go To    https://dr.data-al.cloud/terminplaner/
    Sleep    200ms
    # Step 55: Navigate to 'https://dr.data-al.cloud/terminplaner/event'
    Go To    https://dr.data-al.cloud/terminplaner/event
    Sleep    200ms
    # Step 56: Click element 'IMG'
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_8}    visible    timeout=3s
    IF    ${is_visible}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTNEWDANILOGIN_8}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTNEWDANILOGIN_8}    force=True
        END
    END
    Sleep    200ms
    # Step 57: Click element 'BUTTON'
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_9}    visible    timeout=3s
    IF    ${is_visible}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTNEWDANILOGIN_9}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTNEWDANILOGIN_9}    force=True
        END
    END
    Sleep    200ms
    # Step 58: Click element 'dashboard'
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_12}    visible    timeout=3s
    IF    ${is_visible}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTNEWDANILOGIN_12}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTNEWDANILOGIN_12}    force=True
        END
    END
    Sleep    200ms
    # Step 59: Click element 'settings'
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_5}    visible    timeout=3s
    IF    ${is_visible}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTNEWDANILOGIN_5}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTNEWDANILOGIN_5}    force=True
        END
    END
    Sleep    200ms
    # Step 60: Navigate to 'https://dr.data-al.cloud/users/'
    Go To    https://dr.data-al.cloud/users/
    Sleep    200ms
    # Step 61: Navigate to 'https://dr.data-al.cloud/users/home'
    Go To    https://dr.data-al.cloud/users/home
    Sleep    200ms
    # Step 62: Click element 'IMG'
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_8}    visible    timeout=3s
    IF    ${is_visible}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTNEWDANILOGIN_8}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTNEWDANILOGIN_8}    force=True
        END
    END
    Sleep    200ms
    # Step 63: Click element 'BUTTON'
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_9}    visible    timeout=3s
    IF    ${is_visible}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTNEWDANILOGIN_9}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTNEWDANILOGIN_9}    force=True
        END
    END
    Sleep    200ms
    # Step 64: Click element 'dashboard'
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_12}    visible    timeout=3s
    IF    ${is_visible}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTNEWDANILOGIN_12}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTNEWDANILOGIN_12}    force=True
        END
    END
    Sleep    200ms
    # Step 65: Click element 'dashboard settings people calendar_month'
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_14}    visible    timeout=3s
    IF    ${is_visible}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTNEWDANILOGIN_14}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTNEWDANILOGIN_14}    force=True
        END
    END
    Sleep    200ms
    # Step 66: Click element 'dashboard settings people calendar_month Logout Administrator zum Startbildschirm Passwort ändern Be'
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_15}    visible    timeout=3s
    IF    ${is_visible}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTNEWDANILOGIN_15}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTNEWDANILOGIN_15}    force=True
        END
    END
    Sleep    200ms
    # Step 67: Click element 'dashboard'
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_5}    visible    timeout=3s
    IF    ${is_visible}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTNEWDANILOGIN_5}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTNEWDANILOGIN_5}    force=True
        END
    END
    Sleep    200ms
    # Step 68: Navigate to 'https://dr.data-al.cloud/aldashboard/'
    Go To    https://dr.data-al.cloud/aldashboard/
    Sleep    200ms
    # Step 69: Navigate to 'https://dr.data-al.cloud/aldashboard/home'
    Go To    https://dr.data-al.cloud/aldashboard/home
    Sleep    200ms
    # Step 70: Click element 'IMG'
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_8}    visible    timeout=3s
    IF    ${is_visible}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTNEWDANILOGIN_8}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTNEWDANILOGIN_8}    force=True
        END
    END
    Sleep    200ms
    # Step 71: Click element 'BUTTON'
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_9}    visible    timeout=3s
    IF    ${is_visible}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTNEWDANILOGIN_9}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTNEWDANILOGIN_9}    force=True
        END
    END
    Sleep    200ms
    # Step 72: Click element 'settings'
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_16}    visible    timeout=3s
    IF    ${is_visible}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTNEWDANILOGIN_16}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTNEWDANILOGIN_16}    force=True
        END
    END
    Sleep    200ms
    # Step 73: Click element 'Administrator'
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_17}    visible    timeout=3s
    IF    ${is_visible}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTNEWDANILOGIN_17}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTNEWDANILOGIN_17}    force=True
        END
    END
    Sleep    200ms
    # Step 74: Click element 'Logout Administrator'
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_18}    visible    timeout=3s
    IF    ${is_visible}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTNEWDANILOGIN_18}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTNEWDANILOGIN_18}    force=True
        END
    END
    Sleep    200ms
    # Step 75: Navigate to 'https://dr.data-al.cloud/aldashboard/login'
    Go To    https://dr.data-al.cloud/aldashboard/login
    Sleep    200ms
    # Step 76: Click element 'BUTTON'
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTNEWDANILOGIN_9}    visible    timeout=3s
    IF    ${is_visible}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTNEWDANILOGIN_9}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTNEWDANILOGIN_9}    force=True
        END
    END
    Sleep    200ms
