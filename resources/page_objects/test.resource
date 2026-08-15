*** Settings ***
Documentation    Recorded test block routine for 'Test'.
Library          Browser
Library          ../libraries/visual_hud.py

*** Variables ***
${TEST_START_URL}    https://dr.data-al.cloud/aldashboard/login?returnUrl=%2Fhome
${ACTION_DELAY}                    300ms

${SELECTOR_TEST_1}                                              app-root > mat-sidenav-container > mat-sidenav-content > div > div:nth-of-type(2) > app-login
${SELECTOR_TEST_2}                                              mat-form-field#email > div > div > div > input
${SELECTOR_TEST_3}                                              input[type="password"]
${SELECTOR_TEST_4}                                              mat-icon[role="img"]
${SELECTOR_TEST_5}                                              button:has-text("check")
${SELECTOR_TEST_6}                                              body.mat-typography
${SELECTOR_TEST_7}                                              app-root > mat-sidenav-container > mat-sidenav-content > div > div:nth-of-type(2) > eventcalendar > picker-calendar > div > div > div > div:nth-of-type(10) > img
${SELECTOR_TEST_8}                                              input[role="combobox"]
${SELECTOR_TEST_9}                                              span:has-text("Mustermann, Max 01.01.2000")
${SELECTOR_TEST_10}                                             mat-option[role="option"]
${SELECTOR_TEST_11}                                             app-root > mat-sidenav-container > mat-sidenav-content > div > div:nth-of-type(2) > eventcalendar > mat-drawer-container > mat-drawer-content > div > div:nth-of-type(2) > mbsc-eventcalendar > mbsc-calendar-view > mbsc-scheduler > div:nth-of-type(3) > div:nth-of-type(2) > div > div > div > div:nth-of-type(4) > div > div:nth-of-type(23)
${SELECTOR_TEST_12}                                             app-root > mat-sidenav-container > mat-sidenav-content > div > div > button > span > img
${SELECTOR_TEST_13}                                             button[aria-label="Toggle sidenav"]
${SELECTOR_TEST_14}                                             button:has-text("dashboard")
${SELECTOR_TEST_15}                                             span:has-text("Administrator")
${SELECTOR_TEST_16}                                             a:has-text("Logout Administrator")

*** Keywords ***
Execute Routine Test
    [Documentation]    Executes recorded interaction sequence for Test.
    [Arguments]        ${url}=${TEST_START_URL}
    # Step 1: Navigate to 'https://dr.data-al.cloud/aldashboard/login?returnUrl=%2Fhome'
    Go To    https://dr.data-al.cloud/aldashboard/login?returnUrl=%2Fhome
    Sleep    ${ACTION_DELAY}
    # Step 2: Click element 'Anmelden E-Mail * Passwort * check'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_TEST_1}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_1}
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_1}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_1}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 3: Fill input field 'mat-form-field#email > div > div > div > input'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_TEST_2}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_2}
    Sleep    150ms
    Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: "admin@demo.de"
    Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_2}
    ${fill_ok}=    Run Keyword And Return Status    Fill Text    ${SELECTOR_TEST_2}    admin@demo.de
    IF    not ${fill_ok}
        Run Keyword And Ignore Error    Type Text    ${SELECTOR_TEST_2}    admin@demo.de
    END
    Sleep    ${ACTION_DELAY}
    # Step 4: Fill input field 'input[type="password"]'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_TEST_3}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_3}
    Sleep    150ms
    Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: "admin"
    Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_3}
    ${fill_ok}=    Run Keyword And Return Status    Fill Text    ${SELECTOR_TEST_3}    admin
    IF    not ${fill_ok}
        Run Keyword And Ignore Error    Type Text    ${SELECTOR_TEST_3}    admin
    END
    Sleep    ${ACTION_DELAY}
    # Step 5: Click element 'check'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_TEST_4}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_4}
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_4}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_4}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 6: Click element 'check'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_TEST_5}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_5}
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_5}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_5}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 7: Click element 'calendar_month'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_TEST_4}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_4}
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_4}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_4}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 8: Click element 'help_outline 60 30 20 15 10 5 gewählt: 15.08.2026 Heute August 2026 M D M D F S S 27 29 30 1 2 3 4 5'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_TEST_6}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_6}
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_6}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_6}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 9: Click element 'IMG'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_TEST_7}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_7}
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_7}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_7}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 10: Click element 'IMG'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_TEST_7}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_7}
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_7}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_7}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 11: Click element 'INPUT'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_TEST_8}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_8}
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_8}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_8}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 12: Fill input field 'input[role="combobox"]'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_TEST_8}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_8}
    Sleep    150ms
    Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: "muster"
    Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_8}
    ${fill_ok}=    Run Keyword And Return Status    Fill Text    ${SELECTOR_TEST_8}    muster
    IF    not ${fill_ok}
        Run Keyword And Ignore Error    Type Text    ${SELECTOR_TEST_8}    muster
    END
    Sleep    ${ACTION_DELAY}
    # Step 13: Click element 'Mustermann, Max 01.01.2000'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_TEST_9}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_9}
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_9}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_9}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 14: Click element 'Mustermann, Max 01.01.2000'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_TEST_10}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_10}
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_10}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_10}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 15: Fill input field 'input[role="combobox"]'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_TEST_8}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_8}
    Sleep    150ms
    Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: "Mustermann Max 01.01.2000"
    Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_8}
    ${fill_ok}=    Run Keyword And Return Status    Fill Text    ${SELECTOR_TEST_8}    Mustermann Max 01.01.2000
    IF    not ${fill_ok}
        Run Keyword And Ignore Error    Type Text    ${SELECTOR_TEST_8}    Mustermann Max 01.01.2000
    END
    Sleep    ${ACTION_DELAY}
    # Step 16: Click element 'DIV'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_TEST_11}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_11}
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_11}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_11}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 17: Click element 'DIV'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_TEST_11}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_11}
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_11}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_11}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 18: Click element 'DIV'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_TEST_11}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_11}
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_11}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_11}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 19: Click element 'DIV'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_TEST_11}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_11}
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_11}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_11}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 20: Click element 'IMG'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_TEST_12}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_12}
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_12}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_12}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 21: Click element 'BUTTON'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_TEST_13}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_13}
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_13}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_13}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 22: Click element 'dashboard'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_TEST_14}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_14}
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_14}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_14}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 23: Click element 'Administrator'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_TEST_15}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_15}
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_15}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_15}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 24: Click element 'Logout Administrator'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_TEST_16}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_16}
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_16}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_16}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 25: Click element 'BUTTON'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_TEST_13}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_13}
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_13}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_13}    force=True
    END
    Sleep    ${ACTION_DELAY}
