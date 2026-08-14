*** Settings ***
Documentation    Recorded test block routine for 'asdfasdf'.
Library          Browser
Library          ../libraries/visual_hud.py

*** Variables ***
${ASDFASDF_START_URL}    https://dr.data-al.cloud
${ACTION_DELAY}                    150ms

${SELECTOR_ASDFASDF_1}                                          app-login.ng-star-inserted
${SELECTOR_ASDFASDF_2}                                          #mat-input-0
${SELECTOR_ASDFASDF_3}                                          #mat-input-1
${SELECTOR_ASDFASDF_4}                                          app-root > mat-sidenav-container > mat-sidenav-content > div > div:nth-of-type(2) > app-login > div > form > div:nth-of-type(5) > div
${SELECTOR_ASDFASDF_5}                                          button:has-text("check")
${SELECTOR_ASDFASDF_6}                                          span:has-text("calendar_month Terminplaner")
${SELECTOR_ASDFASDF_7}                                          span:has-text("Mustermann, Max 01.01.2000")
${SELECTOR_ASDFASDF_8}                                          #\[object\ Object\]
${SELECTOR_ASDFASDF_9}                                          app-root > mat-sidenav-container > mat-sidenav-content > div > div:nth-of-type(2) > eventcalendar > mat-drawer-container > mat-drawer-content > div > div:nth-of-type(2) > mbsc-eventcalendar > mbsc-calendar-view > mbsc-scheduler > div:nth-of-type(3) > div:nth-of-type(2) > div > div > div > div:nth-of-type(3) > div > div:nth-of-type(54)
${SELECTOR_ASDFASDF_10}                                         app-root > mat-sidenav-container > mat-sidenav-content > div > div:nth-of-type(2) > eventcalendar > mat-drawer-container > mat-drawer-content > div > div:nth-of-type(2) > mbsc-eventcalendar > mbsc-calendar-view > mbsc-scheduler > div:nth-of-type(3) > div:nth-of-type(2) > div > div > div > div:nth-of-type(3) > div > div > mbsc-schedule-event:nth-of-type(5)
${SELECTOR_ASDFASDF_11}                                         div.mbsc-popup-focus
${SELECTOR_ASDFASDF_12}                                         mbsc-button[role="button"]
${SELECTOR_ASDFASDF_13}                                         app-root > mat-sidenav-container > mat-sidenav-content > div > div:nth-of-type(2) > eventcalendar > mat-drawer-container > mat-drawer-content > div > div:nth-of-type(2) > mbsc-eventcalendar > mbsc-calendar-view > mbsc-scheduler > div:nth-of-type(3) > div:nth-of-type(2) > div > div > div > div:nth-of-type(2) > div > div > mbsc-schedule-event:nth-of-type(7) > div:nth-of-type(3)
${SELECTOR_ASDFASDF_14}                                         app-root > mat-sidenav-container > mat-sidenav-content > div > div:nth-of-type(2) > eventcalendar > mat-drawer-container > mat-drawer-content > div > div:nth-of-type(2) > mbsc-eventcalendar > mbsc-calendar-view > mbsc-scheduler > div:nth-of-type(3) > div:nth-of-type(2) > div > div > div > div:nth-of-type(2) > div > div > mbsc-schedule-event:nth-of-type(7)
${SELECTOR_ASDFASDF_15}                                         #mat-dialog-0
${SELECTOR_ASDFASDF_16}                                         span:has-text("Löschen")
${SELECTOR_ASDFASDF_17}                                         button:has-text("Löschen")
${SELECTOR_ASDFASDF_18}                                         #mat-checkbox-9-input

*** Keywords ***
Execute Routine Asdfasdf
    [Documentation]    Executes recorded interaction sequence for asdfasdf.
    [Arguments]        ${url}=${ASDFASDF_START_URL}
    # Step 1: Navigate to 'https://dr.data-al.cloud/aldashboard/'
    Go To    https://dr.data-al.cloud/aldashboard/
    Sleep    ${ACTION_DELAY}
    # Step 2: Click element 'Anmelden E-Mail * Passwort * check'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDFASDF_1}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDFASDF_1}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDFASDF_1}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ASDFASDF_1}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 3: Fill input field '#mat-input-0'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDFASDF_2}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDFASDF_2}
    Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: "admin@demo.de"
    ${fill_ok}=    Run Keyword And Return Status    Fill Text    ${SELECTOR_ASDFASDF_2}    admin@demo.de
    Sleep    ${ACTION_DELAY}
    # Step 4: Fill input field '#mat-input-1'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDFASDF_3}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDFASDF_3}
    Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: "admin"
    ${fill_ok}=    Run Keyword And Return Status    Fill Text    ${SELECTOR_ASDFASDF_3}    admin
    Sleep    ${ACTION_DELAY}
    # Step 5: Click element 'check'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDFASDF_4}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDFASDF_4}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDFASDF_4}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ASDFASDF_4}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 6: Click element 'check'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDFASDF_5}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDFASDF_5}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDFASDF_5}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ASDFASDF_5}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 7: Click element 'check'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDFASDF_5}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDFASDF_5}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDFASDF_5}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ASDFASDF_5}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 8: Click element 'calendar_month Terminplaner'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDFASDF_6}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDFASDF_6}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDFASDF_6}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ASDFASDF_6}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 9: Click element 'INPUT'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDFASDF_2}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDFASDF_2}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDFASDF_2}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ASDFASDF_2}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 10: Fill input field '#mat-input-0'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDFASDF_2}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDFASDF_2}
    Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: "muster"
    ${fill_ok}=    Run Keyword And Return Status    Fill Text    ${SELECTOR_ASDFASDF_2}    muster
    Sleep    ${ACTION_DELAY}
    # Step 11: Click element 'Mustermann, Max 01.01.2000'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDFASDF_7}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDFASDF_7}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDFASDF_7}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ASDFASDF_7}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 12: Click element 'Mustermann, Max 01.01.2000'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDFASDF_8}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDFASDF_8}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDFASDF_8}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ASDFASDF_8}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 13: Fill input field '#mat-input-0'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDFASDF_2}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDFASDF_2}
    Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: "Mustermann Max 01.01.2000"
    ${fill_ok}=    Run Keyword And Return Status    Fill Text    ${SELECTOR_ASDFASDF_2}    Mustermann Max 01.01.2000
    Sleep    ${ACTION_DELAY}
    # Step 14: Click element 'DIV'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDFASDF_9}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDFASDF_9}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDFASDF_9}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ASDFASDF_9}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 15: Click element 'DIV'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDFASDF_9}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDFASDF_9}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDFASDF_9}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ASDFASDF_9}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 16: Click element 'DIV'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDFASDF_9}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDFASDF_9}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDFASDF_9}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ASDFASDF_9}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 17: Click element 'Mustermann Max Behandlung 18:45 - 19:00'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDFASDF_10}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDFASDF_10}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDFASDF_10}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ASDFASDF_10}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 18: Click element 'DIV'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDFASDF_11}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDFASDF_11}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDFASDF_11}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ASDFASDF_11}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 19: Click element 'JA'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDFASDF_12}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDFASDF_12}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDFASDF_12}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ASDFASDF_12}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 20: Click element 'JA'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDFASDF_12}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDFASDF_12}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDFASDF_12}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ASDFASDF_12}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 21: Click element 'Mustermann Max Behandlung 18:45 - 19:30'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDFASDF_10}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDFASDF_10}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDFASDF_10}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ASDFASDF_10}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 22: Click element 'DIV'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDFASDF_11}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDFASDF_11}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDFASDF_11}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ASDFASDF_11}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 23: Click element 'JA'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDFASDF_12}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDFASDF_12}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDFASDF_12}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ASDFASDF_12}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 24: Click element 'JA'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDFASDF_12}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDFASDF_12}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDFASDF_12}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ASDFASDF_12}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 25: Click element 'Mustermann Max Behandlung 18:45 - 19:30'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDFASDF_13}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDFASDF_13}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDFASDF_13}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ASDFASDF_13}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 26: Click element 'Mustermann Max Behandlung 18:45 - 19:30'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDFASDF_14}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDFASDF_14}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDFASDF_14}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ASDFASDF_14}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 27: Click element 'Termin bearbeiten help_outline Umwandeln zu Gruppentermin Zum Patienten Termin (Leistung) help_outli'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDFASDF_15}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDFASDF_15}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDFASDF_15}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ASDFASDF_15}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 28: Click element 'Löschen'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDFASDF_16}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDFASDF_16}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDFASDF_16}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ASDFASDF_16}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 29: Click element 'Löschen'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDFASDF_17}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDFASDF_17}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDFASDF_17}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ASDFASDF_17}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 30: Click element 'Mustermann Max Behandlung 18:45 - 19:30'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDFASDF_14}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDFASDF_14}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDFASDF_14}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ASDFASDF_14}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 31: Fill input field '#mat-checkbox-9-input'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDFASDF_18}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDFASDF_18}
    Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: "on"
    ${fill_ok}=    Run Keyword And Return Status    Fill Text    ${SELECTOR_ASDFASDF_18}    on
    Sleep    ${ACTION_DELAY}
    # Step 32: Click element 'Löschen'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDFASDF_16}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDFASDF_16}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDFASDF_16}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ASDFASDF_16}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 33: Click element 'Löschen'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDFASDF_17}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDFASDF_17}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDFASDF_17}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ASDFASDF_17}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 34: Click element 'Mustermann Max Behandlung 18:45 - 19:30'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDFASDF_14}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDFASDF_14}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDFASDF_14}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ASDFASDF_14}    force=True
    END
    Sleep    ${ACTION_DELAY}
