*** Settings ***
Documentation    Recorded test block routine for 'test'.
Library          Browser
Library          ../libraries/visual_hud.py

*** Variables ***
${TEST_START_URL}    https://dr.data-al.cloud
${ACTION_DELAY}                    300ms

${SELECTOR_TEST_1}                                              app-root > mat-sidenav-container > mat-sidenav-content > div > div:nth-of-type(2) > app-login
${SELECTOR_TEST_2}                                              mat-form-field#email > div > div > div > input
${SELECTOR_TEST_3}                                              input[type="password"]
${SELECTOR_TEST_4}                                              mat-icon[role="img"]
${SELECTOR_TEST_5}                                              button:has-text("check")
${SELECTOR_TEST_6}                                              span:has-text("calendar_month Terminplaner")
${SELECTOR_TEST_7}                                              app-root > mat-sidenav-container > mat-sidenav-content > div > div:nth-of-type(2) > eventcalendar > picker-calendar > div > div > div > div:nth-of-type(10) > img
${SELECTOR_TEST_8}                                              app-root > mat-sidenav-container > mat-sidenav-content > div > div:nth-of-type(2) > eventcalendar > mat-drawer-container > mat-drawer-content > div > div:nth-of-type(2) > mbsc-eventcalendar > mbsc-calendar-view > mbsc-scheduler > div:nth-of-type(3) > div:nth-of-type(2) > div > div > div > div:nth-of-type(4) > div > div:nth-of-type(26)
${SELECTOR_TEST_9}                                              div:has-text("Behandlung 11:45 - 12:00")
${SELECTOR_TEST_10}                                             app-root > mat-sidenav-container > mat-sidenav-content > div > div:nth-of-type(2) > eventcalendar > mat-drawer-container > mat-drawer-content > div > div:nth-of-type(2) > mbsc-eventcalendar > mbsc-calendar-view > mbsc-scheduler > div:nth-of-type(3) > div:nth-of-type(2) > div > div > div > div:nth-of-type(4) > div > div > mbsc-schedule-event
${SELECTOR_TEST_11}                                             #mat-dialog-0
${SELECTOR_TEST_12}                                             span:has-text("Patient zuweisen")
${SELECTOR_TEST_13}                                             button:has-text("Patient zuweisen")
${SELECTOR_TEST_14}                                             input[role="combobox"]
${SELECTOR_TEST_15}                                             span:has-text("Mustermann, Max 01.01.2000")
${SELECTOR_TEST_16}                                             mat-option[role="option"]
${SELECTOR_TEST_17}                                             span:has-text("Speichern")
${SELECTOR_TEST_18}                                             button:has-text("Speichern")
${SELECTOR_TEST_19}                                             span:has-text("11:45 - 12:00")
${SELECTOR_TEST_20}                                             #mat-dialog-1
${SELECTOR_TEST_21}                                             div.cdk-overlay-backdrop.cdk-overlay-dark-backdrop
${SELECTOR_TEST_22}                                             button:has-text("Abbruch")

*** Keywords ***
Execute Routine Test
    [Documentation]    Executes recorded interaction sequence for test.
    [Arguments]        ${url}=${TEST_START_URL}
    # Step 1: Navigate to 'https://dr.data-al.cloud/aldashboard/'
    Go To    https://dr.data-al.cloud/aldashboard/
    Sleep    ${ACTION_DELAY}
    # Step 2: Klick auf Element 'Anmelden E-Mail * Passwort * check'
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
    ${type_ok}=    Run Keyword And Return Status    Type Text    ${SELECTOR_TEST_2}    admin@demo.de    delay=40ms
    IF    not ${type_ok}
        Run Keyword And Ignore Error    Fill Text    ${SELECTOR_TEST_2}    admin@demo.de
    END
    Sleep    ${ACTION_DELAY}
    # Step 4: Fill input field 'input[type="password"]'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_TEST_3}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_3}
    Sleep    150ms
    Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: "admin"
    Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_3}
    ${type_ok}=    Run Keyword And Return Status    Type Text    ${SELECTOR_TEST_3}    admin    delay=40ms
    IF    not ${type_ok}
        Run Keyword And Ignore Error    Fill Text    ${SELECTOR_TEST_3}    admin
    END
    Sleep    ${ACTION_DELAY}
    # Step 5: Klick auf Element 'check'
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
    # Step 7: Klick auf Element 'calendar_month Terminplaner'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_TEST_6}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_6}
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_6}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_6}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 8: Klick auf Element 'IMG'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_TEST_7}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_7}
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_7}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_7}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 9: Doppelklick auf Element 'DIV'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_TEST_8}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_8}
    Sleep    150ms
    ${dbl_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_8}    click_count=2
    IF    not ${dbl_ok}
        Run Keyword And Ignore Error    Evaluate JavaScript    ${SELECTOR_TEST_8}    (el) => { if(el) { el.dispatchEvent(new MouseEvent('mousedown', {bubbles: true, detail: 1})); el.dispatchEvent(new MouseEvent('mouseup', {bubbles: true, detail: 1})); el.dispatchEvent(new MouseEvent('click', {bubbles: true, detail: 1})); el.dispatchEvent(new MouseEvent('mousedown', {bubbles: true, detail: 2})); el.dispatchEvent(new MouseEvent('mouseup', {bubbles: true, detail: 2})); el.dispatchEvent(new MouseEvent('click', {bubbles: true, detail: 2})); el.dispatchEvent(new MouseEvent('dblclick', {bubbles: true, detail: 2})); } }
    END
    Sleep    ${ACTION_DELAY}
    # Step 10: Klick auf Element 'Behandlung 11:45 - 12:00'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_TEST_9}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_9}
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_9}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_9}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 11: Click element 'Behandlung 11:45 - 12:00'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_TEST_10}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_10}
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_10}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_10}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 12: Click element 'Termin bearbeiten help_outline Umwandeln zu Gruppentermin Patient zuweisen Termin (Leistung) help_ou'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_TEST_11}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_11}
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_11}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_11}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 13: Klick auf Element 'Patient zuweisen'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_TEST_12}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_12}
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_12}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_12}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 14: Click element 'Patient zuweisen'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_TEST_13}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_13}
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_13}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_13}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 15: Klick auf Element 'INPUT'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_TEST_14}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_14}
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_14}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_14}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 16: Fill input field 'input[role="combobox"]'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_TEST_14}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_14}
    Sleep    150ms
    Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: "mustermann"
    Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_14}
    ${type_ok}=    Run Keyword And Return Status    Type Text    ${SELECTOR_TEST_14}    mustermann    delay=40ms
    IF    not ${type_ok}
        Run Keyword And Ignore Error    Fill Text    ${SELECTOR_TEST_14}    mustermann
    END
    Sleep    ${ACTION_DELAY}
    # Step 17: Klick auf Element 'Mustermann, Max 01.01.2000'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_TEST_15}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_15}
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_15}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_15}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 18: Click element 'Mustermann, Max 01.01.2000'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_TEST_16}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_16}
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_16}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_16}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 19: Fill input field 'input[role="combobox"]'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_TEST_14}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_14}
    Sleep    150ms
    Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: "Mustermann Max 01.01.2000"
    Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_14}
    ${type_ok}=    Run Keyword And Return Status    Type Text    ${SELECTOR_TEST_14}    Mustermann Max 01.01.2000    delay=40ms
    IF    not ${type_ok}
        Run Keyword And Ignore Error    Fill Text    ${SELECTOR_TEST_14}    Mustermann Max 01.01.2000
    END
    Sleep    ${ACTION_DELAY}
    # Step 20: Klick auf Element 'Speichern'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_TEST_17}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_17}
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_17}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_17}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 21: Click element 'Speichern'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_TEST_18}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_18}
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_18}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_18}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 22: Klick auf Element '11:45 - 12:00'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_TEST_19}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_19}
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_19}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_19}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 23: Click element 'Max Mustermann Behandlung 11:45 - 12:00'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_TEST_10}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_10}
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_10}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_10}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 24: Click element 'Termin bearbeiten help_outline Umwandeln zu Gruppentermin Zum Patienten Termin (Leistung) help_outli'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_TEST_20}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_20}
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_20}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_20}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 25: Klick auf Element 'DIV'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_TEST_21}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_21}
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_21}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_21}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 26: Click element 'Termin bearbeiten help_outline Umwandeln zu Gruppentermin Zum Patienten Termin (Leistung) help_outli'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_TEST_20}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_20}
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_20}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_20}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 27: Klick auf Element 'Abbruch'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_TEST_22}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_22}
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_22}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_22}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 28: Click element 'Abbruch'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_TEST_22}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_22}
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_22}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_22}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 29: Click element 'Max Mustermann Behandlung 11:45 - 12:00'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_TEST_10}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_10}
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_10}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_10}    force=True
    END
    Sleep    ${ACTION_DELAY}
