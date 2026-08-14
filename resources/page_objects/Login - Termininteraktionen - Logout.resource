*** Settings ***
Documentation    Recorded test block routine for 'Login - Termininteraktionen - Logout'.
Library          Browser
Library          ../libraries/visual_hud.py

*** Variables ***
${LOGIN_TERMININTERAKTIONEN_LOGOUT_START_URL}    https://dr.data-al.cloud
${ACTION_DELAY}                    150ms

${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_1}                  app-login.ng-star-inserted
${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_2}                  #mat-input-0
${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_3}                  #mat-input-1
${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_4}                  mat-icon[role="img"]
${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_5}                  button:has-text("check")
${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_6}                  span:has-text("Mustermann, Max 01.01.2000")
${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_7}                  #\[object\ Object\]
${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_8}                  app-root > mat-sidenav-container > mat-sidenav-content > div > div:nth-of-type(2) > eventcalendar > mat-drawer-container > mat-drawer-content > div > div:nth-of-type(2) > mbsc-eventcalendar > mbsc-calendar-view > mbsc-scheduler > div:nth-of-type(3) > div:nth-of-type(2) > div > div > div > div:nth-of-type(3) > div > div:nth-of-type(54)
${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_9}                  app-root > mat-sidenav-container > mat-sidenav-content > div > div:nth-of-type(2) > eventcalendar > mat-drawer-container > mat-drawer-content > div > div:nth-of-type(2) > mbsc-eventcalendar > mbsc-calendar-view > mbsc-scheduler > div:nth-of-type(3) > div:nth-of-type(2) > div > div > div > div:nth-of-type(3) > div > div > mbsc-schedule-event:nth-of-type(5) > div:nth-of-type(3) > div:nth-of-type(3)
${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_10}                 app-root > mat-sidenav-container > mat-sidenav-content > div > div:nth-of-type(2) > eventcalendar > mat-drawer-container > mat-drawer-content > div > div:nth-of-type(2) > mbsc-eventcalendar > mbsc-calendar-view > mbsc-scheduler > div:nth-of-type(3) > div:nth-of-type(2) > div > div > div > div:nth-of-type(3) > div > div > mbsc-schedule-event:nth-of-type(5)
${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_11}                 #mat-dialog-0
${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_12}                 span:has-text("Löschen")
${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_13}                 button:has-text("Löschen")
${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_14}                 #mat-checkbox-9-input
${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_15}                 mat-dialog-actions.mat-dialog-actions
${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_16}                 #mat-dialog-1
${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_17}                 app-root > mat-sidenav-container > mat-sidenav-content > div > div:nth-of-type(2) > eventcalendar > mat-drawer-container > mat-drawer-content > div > div:nth-of-type(2) > mbsc-eventcalendar > mbsc-calendar-view > mbsc-scheduler > div:nth-of-type(3) > div:nth-of-type(2) > div > div > div > div:nth-of-type(4) > div > div:nth-of-type(54)
${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_18}                 app-root > mat-sidenav-container > mat-sidenav-content > div > div:nth-of-type(2) > eventcalendar > mat-drawer-container > mat-drawer-content > div > div:nth-of-type(2) > mbsc-eventcalendar > mbsc-calendar-view > mbsc-scheduler > div:nth-of-type(3) > div:nth-of-type(2) > div > div > div > div:nth-of-type(4) > div > div > mbsc-schedule-event
${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_19}                 div.mbsc-popup-focus
${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_20}                 mbsc-button[role="button"]
${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_21}                 app-root > mat-sidenav-container > mat-sidenav-content > div > div:nth-of-type(2) > eventcalendar > mat-drawer-container > mat-drawer-content > div > div:nth-of-type(2) > mbsc-eventcalendar > mbsc-calendar-view > mbsc-scheduler > div:nth-of-type(3) > div:nth-of-type(2) > div > div > div > div:nth-of-type(3) > div > div > mbsc-schedule-event:nth-of-type(5) > div:nth-of-type(3)
${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_22}                 #mat-dialog-2
${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_23}                 #mat-checkbox-15-input
${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_24}                 app-root > mat-sidenav-container > mat-sidenav-content > div > div > button > span > img
${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_25}                 button[aria-label="Toggle sidenav"]
${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_26}                 button:has-text("dashboard")
${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_27}                 span:has-text("Administrator")
${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_28}                 a:has-text("Logout Administrator")

*** Keywords ***
Execute Routine Login   Termininteraktionen   Logout
    [Documentation]    Executes recorded interaction sequence for Login - Termininteraktionen - Logout.
    [Arguments]        ${url}=${LOGIN_TERMININTERAKTIONEN_LOGOUT_START_URL}
    # Step 1: Navigate to 'https://dr.data-al.cloud/aldashboard/'
    Go To    https://dr.data-al.cloud/aldashboard/
    Sleep    ${ACTION_DELAY}
    # Step 2: Click element 'Anmelden E-Mail * Passwort * check'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_1}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_1}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_1}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_1}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 3: Fill input field '#mat-input-0'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_2}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_2}
    Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: "admin@demo.de"
    ${fill_ok}=    Run Keyword And Return Status    Fill Text    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_2}    admin@demo.de
    Sleep    ${ACTION_DELAY}
    # Step 4: Fill input field '#mat-input-1'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_3}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_3}
    Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: "admin"
    ${fill_ok}=    Run Keyword And Return Status    Fill Text    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_3}    admin
    Sleep    ${ACTION_DELAY}
    # Step 5: Click element 'check'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_4}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_4}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_4}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_4}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 6: Click element 'check'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_5}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_5}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_5}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_5}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 7: Click element 'calendar_month'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_4}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_4}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_4}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_4}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 8: Click element 'INPUT'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_2}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_2}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_2}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_2}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 9: Fill input field '#mat-input-0'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_2}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_2}
    Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: "mustermann"
    ${fill_ok}=    Run Keyword And Return Status    Fill Text    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_2}    mustermann
    Sleep    ${ACTION_DELAY}
    # Step 10: Click element 'Mustermann, Max 01.01.2000'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_6}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_6}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_6}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_6}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 11: Click element 'Mustermann, Max 01.01.2000'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_7}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_7}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_7}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_7}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 12: Fill input field '#mat-input-0'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_2}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_2}
    Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: "Mustermann Max 01.01.2000"
    ${fill_ok}=    Run Keyword And Return Status    Fill Text    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_2}    Mustermann Max 01.01.2000
    Sleep    ${ACTION_DELAY}
    # Step 13: Click element 'DIV'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_8}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_8}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_8}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_8}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 14: Click element 'DIV'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_8}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_8}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_8}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_8}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 15: Click element 'DIV'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_8}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_8}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_8}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_8}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 16: Click element 'Behandlung 18:45 - 19:00'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_9}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_9}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_9}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_9}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 17: Click element 'Mustermann Max Behandlung 18:45 - 19:00'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_10}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_10}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_10}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_10}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 18: Click element 'Termin bearbeiten help_outline Umwandeln zu Gruppentermin Zum Patienten Termin (Leistung) help_outli'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_11}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_11}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_11}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_11}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 19: Click element 'Löschen'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_12}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_12}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_12}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_12}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 20: Click element 'Löschen'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_13}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_13}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_13}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_13}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 21: Click element 'Mustermann Max Behandlung 18:45 - 19:00'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_10}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_10}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_10}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_10}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 22: Fill input field '#mat-checkbox-9-input'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_14}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_14}
    Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: "on"
    ${fill_ok}=    Run Keyword And Return Status    Fill Text    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_14}    on
    Sleep    ${ACTION_DELAY}
    # Step 23: Click element 'Löschen Abbruch'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_15}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_15}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_15}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_15}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 24: Click element 'Hinweis Es werden auch die zugehörigen Termine für "Behandlung", "Mustermann Max Teststraße 42 12345'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_16}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_16}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_16}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_16}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 25: Click element 'Löschen'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_12}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_12}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_12}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_12}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 26: Click element 'Löschen'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_13}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_13}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_13}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_13}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 27: Click element 'Mustermann Max Behandlung 18:45 - 19:00'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_10}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_10}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_10}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_10}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 28: Click element 'DIV'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_17}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_17}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_17}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_17}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 29: Click element 'DIV'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_17}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_17}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_17}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_17}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 30: Click element 'DIV'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_17}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_17}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_17}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_17}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 31: Click element 'Mustermann Max Behandlung 18:45 - 19:00'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_18}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_18}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_18}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_18}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 32: Click element 'DIV'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_19}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_19}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_19}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_19}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 33: Click element 'JA'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_20}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_20}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_20}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_20}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 34: Click element 'JA'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_20}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_20}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_20}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_20}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 35: Click element 'Mustermann Max Behandlung 18:45 - 19:45'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_18}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_18}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_18}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_18}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 36: Click element 'DIV'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_19}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_19}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_19}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_19}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 37: Click element 'JA'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_20}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_20}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_20}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_20}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 38: Click element 'JA'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_20}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_20}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_20}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_20}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 39: Click element 'Mustermann Max Behandlung 18:45 - 19:45'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_21}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_21}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_21}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_21}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 40: Click element 'Mustermann Max Behandlung 18:45 - 19:45'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_10}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_10}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_10}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_10}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 41: Click element 'Termin bearbeiten help_outline Umwandeln zu Gruppentermin Zum Patienten Termin (Leistung) help_outli'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_22}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_22}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_22}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_22}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 42: Click element 'Löschen'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_13}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_13}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_13}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_13}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 43: Click element 'Löschen'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_13}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_13}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_13}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_13}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 44: Click element 'Mustermann Max Behandlung 18:45 - 19:45'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_10}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_10}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_10}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_10}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 45: Fill input field '#mat-checkbox-15-input'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_23}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_23}
    Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: "on"
    ${fill_ok}=    Run Keyword And Return Status    Fill Text    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_23}    on
    Sleep    ${ACTION_DELAY}
    # Step 46: Click element 'Löschen'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_12}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_12}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_12}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_12}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 47: Click element 'Löschen'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_13}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_13}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_13}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_13}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 48: Click element 'Mustermann Max Behandlung 18:45 - 19:45'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_10}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_10}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_10}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_10}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 49: Click element 'IMG'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_24}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_24}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_24}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_24}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 50: Click element 'BUTTON'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_25}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_25}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_25}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_25}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 51: Click element 'dashboard'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_26}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_26}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_26}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_26}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 52: Click element 'Administrator'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_27}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_27}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_27}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_27}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 53: Click element 'Logout Administrator'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_28}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_28}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_28}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_28}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 54: Click element 'BUTTON'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_25}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_25}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_25}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_TERMININTERAKTIONEN_LOGOUT_25}    force=True
    END
    Sleep    ${ACTION_DELAY}
