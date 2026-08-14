*** Settings ***
Documentation    Recorded test block routine for 'testitest'.
Library          Browser
Library          ../libraries/visual_hud.py

*** Variables ***
${TESTITEST_START_URL}    https://dr.data-al.cloud
${ACTION_DELAY}                    150ms

${SELECTOR_TESTITEST_1}             mat-icon[role="img"]
${SELECTOR_TESTITEST_2}             button:has-text("check")
${SELECTOR_TESTITEST_3}             div.mat-form-field-infix.ng-tns-c148-2
${SELECTOR_TESTITEST_4}             #mat-input-0
${SELECTOR_TESTITEST_5}             span:has-text("Mustermann, Max 01.01.2000")
${SELECTOR_TESTITEST_6}             #\[object\ Object\]
${SELECTOR_TESTITEST_7}             div#mat-select-value-1 > span
${SELECTOR_TESTITEST_8}             #mat-select-0
${SELECTOR_TESTITEST_9}             span:has-text("Funktionsanalyse")
${SELECTOR_TESTITEST_10}            #mat-option-8
${SELECTOR_TESTITEST_11}            app-root > mat-sidenav-container > mat-sidenav-content > div > div:nth-of-type(2) > eventcalendar > mat-drawer-container > mat-drawer-content > div > div:nth-of-type(2) > mbsc-eventcalendar > mbsc-calendar-view > mbsc-scheduler > div:nth-of-type(3) > div:nth-of-type(2) > div > div > div > div > div > div:nth-of-type(52)
${SELECTOR_TESTITEST_12}            app-root > mat-sidenav-container > mat-sidenav-content > div > div:nth-of-type(2) > eventcalendar > mat-drawer-container > mat-drawer-content > div > div:nth-of-type(2) > mbsc-eventcalendar > mbsc-calendar-view > mbsc-scheduler > div:nth-of-type(3) > div:nth-of-type(2) > div > div > div > div > div > div:nth-of-type(54)
${SELECTOR_TESTITEST_13}            app-root > mat-sidenav-container > mat-sidenav-content > div > div:nth-of-type(2) > eventcalendar > mat-drawer-container > mat-drawer-content > div > div:nth-of-type(2) > mbsc-eventcalendar > mbsc-calendar-view > mbsc-scheduler > div:nth-of-type(3) > div:nth-of-type(2) > div > div > div > div > div > div > mbsc-schedule-event:nth-of-type(8) > div:nth-of-type(3) > div:nth-of-type(3)
${SELECTOR_TESTITEST_14}            app-root > mat-sidenav-container > mat-sidenav-content > div > div:nth-of-type(2) > eventcalendar > mat-drawer-container > mat-drawer-content > div > div:nth-of-type(2) > mbsc-eventcalendar > mbsc-calendar-view > mbsc-scheduler > div:nth-of-type(3) > div:nth-of-type(2) > div > div > div > div > div > div > mbsc-schedule-event:nth-of-type(8)
${SELECTOR_TESTITEST_15}            #mat-dialog-0
${SELECTOR_TESTITEST_16}            span:has-text("Löschen")
${SELECTOR_TESTITEST_17}            button:has-text("Löschen")
${SELECTOR_TESTITEST_18}            #mat-checkbox-9-input
${SELECTOR_TESTITEST_19}            app-root > mat-sidenav-container > mat-sidenav-content > div > div:nth-of-type(2) > eventcalendar > mat-drawer-container > mat-drawer-content > div > div:nth-of-type(2) > mbsc-eventcalendar > mbsc-calendar-view > mbsc-scheduler > div:nth-of-type(3) > div:nth-of-type(2) > div > div > div > div > div > div:nth-of-type(53)
${SELECTOR_TESTITEST_20}            app-root > mat-sidenav-container > mat-sidenav-content > div > div:nth-of-type(2) > eventcalendar > mat-drawer-container > mat-drawer-content > div > div:nth-of-type(2) > mbsc-eventcalendar > mbsc-calendar-view > mbsc-scheduler > div:nth-of-type(3) > div:nth-of-type(2) > div > div > div > div > div > div > mbsc-schedule-event:nth-of-type(7)
${SELECTOR_TESTITEST_21}            div.mbsc-popup-focus
${SELECTOR_TESTITEST_22}            mbsc-button[role="button"]
${SELECTOR_TESTITEST_23}            app-root > mat-sidenav-container > mat-sidenav-content > div > div:nth-of-type(2) > eventcalendar > mat-drawer-container > mat-drawer-content > div > div:nth-of-type(2) > mbsc-eventcalendar > mbsc-calendar-view > mbsc-scheduler > div:nth-of-type(3) > div:nth-of-type(2) > div > div > div > div > div > div > mbsc-schedule-event:nth-of-type(7) > div:nth-of-type(3) > div:nth-of-type(3)
${SELECTOR_TESTITEST_24}            #mat-dialog-2
${SELECTOR_TESTITEST_25}            #mat-input-16
${SELECTOR_TESTITEST_26}            #mat-input-17
${SELECTOR_TESTITEST_27}            div.mat-form-field-infix.ng-tns-c148-40
${SELECTOR_TESTITEST_28}            span:has-text("Speichern")
${SELECTOR_TESTITEST_29}            button:has-text("Speichern")
${SELECTOR_TESTITEST_30}            app-root > mat-sidenav-container > mat-sidenav-content > div > div:nth-of-type(2) > eventcalendar > mat-drawer-container > mat-drawer-content > div > div:nth-of-type(2) > mbsc-eventcalendar > mbsc-calendar-view > mbsc-scheduler > div:nth-of-type(3) > div:nth-of-type(2) > div > div > div > div > div > div > mbsc-schedule-event:nth-of-type(7) > div:nth-of-type(3)
${SELECTOR_TESTITEST_31}            #mat-dialog-3
${SELECTOR_TESTITEST_32}            button:has-text("content_copy")
${SELECTOR_TESTITEST_33}            app-root > mat-sidenav-container > mat-sidenav-content > div > div:nth-of-type(2) > eventcalendar > picker-calendar > div > div > div > div:nth-of-type(12) > img
${SELECTOR_TESTITEST_34}            input[role="combobox"]
${SELECTOR_TESTITEST_35}            mat-slide-toggle#mat-slide-toggle-1 > label > div > div > div
${SELECTOR_TESTITEST_36}            #mat-slide-toggle-1-input
${SELECTOR_TESTITEST_37}            mat-slide-toggle#mat-slide-toggle-1 > label > div

*** Keywords ***
Execute Routine Testitest
    [Documentation]    Executes recorded interaction sequence for testitest.
    [Arguments]        ${url}=${TESTITEST_START_URL}
    # Step 1: Navigate to 'https://dr.data-al.cloud/aldashboard/'
    Go To    https://dr.data-al.cloud/aldashboard/
    Sleep    ${ACTION_DELAY}
    # Step 2: Navigate to 'https://dr.data-al.cloud/aldashboard/login?returnUrl=%2Fhome'
    Go To    https://dr.data-al.cloud/aldashboard/login?returnUrl=%2Fhome
    Sleep    ${ACTION_DELAY}
    # Step 3: Click element 'check'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_1}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_1}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_1}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 4: Click element 'check'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_2}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_2}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_2}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 5: Navigate to 'https://dr.data-al.cloud/aldashboard/home'
    Go To    https://dr.data-al.cloud/aldashboard/home
    Sleep    ${ACTION_DELAY}
    # Step 6: Click element 'calendar_month'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_1}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_1}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_1}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 7: Navigate to 'https://dr.data-al.cloud/terminplaner/'
    Go To    https://dr.data-al.cloud/terminplaner/
    Sleep    ${ACTION_DELAY}
    # Step 8: Navigate to 'https://dr.data-al.cloud/terminplaner/event'
    Go To    https://dr.data-al.cloud/terminplaner/event
    Sleep    ${ACTION_DELAY}
    # Step 9: Click element 'Suche Patient (Name oder ID)'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_3}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_3}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_3}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 10: Fill input field '#mat-input-0'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_4}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: "mus"
        END
        Fill Text    ${SELECTOR_TESTITEST_4}    mus
    END
    Sleep    ${ACTION_DELAY}
    # Step 11: Click element 'Mustermann, Max 01.01.2000'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_5}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_5}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_5}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 12: Click element 'Mustermann, Max 01.01.2000'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_6}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_6}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_6}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 13: Fill input field '#mat-input-0'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_4}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: "Mustermann Max 01.01.2000"
        END
        Fill Text    ${SELECTOR_TESTITEST_4}    Mustermann Max 01.01.2000
    END
    Sleep    ${ACTION_DELAY}
    # Step 14: Click element 'SPAN'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_7}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_7}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_7}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 15: Click element 'MAT-SELECT'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_8}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_8}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_8}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 16: Click element 'Funktionsanalyse'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_9}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_9}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_9}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 17: Click element 'Funktionsanalyse'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_10}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_10}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_10}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 18: Click element 'Funktionsanalyse'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_8}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_8}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_8}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 19: Click element 'DIV'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_11}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_11}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_11}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 20: Click element 'DIV'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_11}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_11}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_11}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 21: Click element 'DIV'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_11}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_11}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_11}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 22: Click element 'DIV'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_12}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_12}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_12}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 23: Click element 'DIV'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_12}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_12}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_12}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 24: Click element 'DIV'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_12}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_12}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_12}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 25: Click element 'Funktionsanalyse 18:45 - 19:00'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_13}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_13}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_13}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 26: Click element 'Mustermann Max Funktionsanalyse 18:45 - 19:00'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_14}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_14}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_14}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 27: Click element 'Termin bearbeiten help_outline Umwandeln zu Gruppentermin Zum Patienten Termin (Leistung) help_outli'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_15}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_15}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_15}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 28: Click element 'Löschen'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_16}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_16}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_16}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 29: Click element 'Löschen'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_17}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_17}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_17}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 30: Click element 'Mustermann Max Funktionsanalyse 18:45 - 19:00'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_14}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_14}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_14}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 31: Fill input field '#mat-checkbox-9-input'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_18}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: "on"
        END
        Fill Text    ${SELECTOR_TESTITEST_18}    on
    END
    Sleep    ${ACTION_DELAY}
    # Step 32: Click element 'Löschen'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_16}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_16}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_16}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 33: Click element 'Löschen'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_17}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_17}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_17}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 34: Click element 'Mustermann Max Funktionsanalyse 18:45 - 19:00'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_14}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_14}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_14}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 35: Click element 'DIV'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_19}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_19}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_19}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 36: Click element 'DIV'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_19}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_19}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_19}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 37: Click element 'DIV'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_19}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_19}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_19}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 38: Click element 'Mustermann Max Funktionsanalyse 18:30 - 18:45'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_20}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_20}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_20}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 39: Click element 'DIV'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_21}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_21}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_21}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 40: Click element 'JA'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_22}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_22}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_22}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 41: Click element 'JA'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_22}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_22}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_22}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 42: Click element 'Funktionsanalyse 19:05 - 19:20'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_23}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_23}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_23}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 43: Click element 'Mustermann Max Funktionsanalyse 19:05 - 19:20'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_20}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_20}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_20}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 44: Click element 'Termin bearbeiten help_outline Umwandeln zu Gruppentermin Zum Patienten Termin (Leistung) help_outli'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_24}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_24}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_24}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 45: Click element 'INPUT'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_25}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_25}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_25}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 46: Fill input field '#mat-input-16'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_25}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: "2026-08-14T19:05"
        END
        Fill Text    ${SELECTOR_TESTITEST_25}    2026-08-14T19:05
    END
    Sleep    ${ACTION_DELAY}
    # Step 47: Click element 'INPUT'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_26}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_26}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_26}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 48: Fill input field '#mat-input-17'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_26}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: "15"
        END
        Fill Text    ${SELECTOR_TESTITEST_26}    15
    END
    Sleep    ${ACTION_DELAY}
    # Step 49: Click element 'Dauer Min.'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_27}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_27}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_27}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 50: Click element 'Termin bearbeiten help_outline Umwandeln zu Gruppentermin Zum Patienten Termin (Leistung) help_outli'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_24}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_24}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_24}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 51: Fill input field '#mat-input-17'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_26}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: "20"
        END
        Fill Text    ${SELECTOR_TESTITEST_26}    20
    END
    Sleep    ${ACTION_DELAY}
    # Step 52: Click element 'INPUT'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_26}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_26}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_26}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 53: Fill input field '#mat-input-17'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_26}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: "30"
        END
        Fill Text    ${SELECTOR_TESTITEST_26}    30
    END
    Sleep    ${ACTION_DELAY}
    # Step 54: Click element 'INPUT'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_26}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_26}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_26}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 55: Fill input field '#mat-input-17'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_26}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: "40"
        END
        Fill Text    ${SELECTOR_TESTITEST_26}    40
    END
    Sleep    ${ACTION_DELAY}
    # Step 56: Click element 'INPUT'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_26}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_26}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_26}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 57: Click element 'INPUT'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_26}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_26}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_26}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 58: Fill input field '#mat-input-17'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_26}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: "50"
        END
        Fill Text    ${SELECTOR_TESTITEST_26}    50
    END
    Sleep    ${ACTION_DELAY}
    # Step 59: Click element 'INPUT'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_26}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_26}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_26}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 60: Fill input field '#mat-input-17'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_26}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: "60"
        END
        Fill Text    ${SELECTOR_TESTITEST_26}    60
    END
    Sleep    ${ACTION_DELAY}
    # Step 61: Click element 'INPUT'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_26}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_26}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_26}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 62: Fill input field '#mat-input-17'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_26}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: "70"
        END
        Fill Text    ${SELECTOR_TESTITEST_26}    70
    END
    Sleep    ${ACTION_DELAY}
    # Step 63: Click element 'INPUT'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_26}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_26}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_26}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 64: Fill input field '#mat-input-17'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_26}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: "80"
        END
        Fill Text    ${SELECTOR_TESTITEST_26}    80
    END
    Sleep    ${ACTION_DELAY}
    # Step 65: Click element 'INPUT'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_26}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_26}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_26}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 66: Fill input field '#mat-input-17'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_26}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: "80"
        END
        Fill Text    ${SELECTOR_TESTITEST_26}    80
    END
    Sleep    ${ACTION_DELAY}
    # Step 67: Click element 'Speichern'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_28}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_28}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_28}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 68: Click element 'Speichern'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_29}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_29}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_29}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 69: Click element 'Mustermann Max Funktionsanalyse 19:05 - 20:25'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_30}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_30}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_30}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 70: Click element 'Mustermann Max Funktionsanalyse 19:05 - 20:25'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_20}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_20}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_20}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 71: Click element 'Termin bearbeiten help_outline Umwandeln zu Gruppentermin Zum Patienten Termin (Leistung) help_outli'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_31}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_31}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_31}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 72: Click element 'content_copy'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_1}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_1}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_1}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 73: Click element 'content_copy'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_32}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_32}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_32}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 74: Click element 'Mustermann Max Funktionsanalyse 19:05 - 20:25'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_20}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_20}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_20}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 75: Click element 'IMG'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_33}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_33}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_33}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 76: Click element 'IMG'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_33}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_33}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_33}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 77: Click element 'IMG'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_33}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_33}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_33}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 78: Click element 'DIV'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_19}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_19}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_19}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 79: Click element 'DIV'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_19}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_19}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_19}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 80: Click element 'DIV'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_19}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_19}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_19}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 81: Click element 'people'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_1}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_1}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_1}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 82: Navigate to 'https://dr.data-al.cloud/patienten/patientenstamm/MST4PMPX-8M5AI'
    Go To    https://dr.data-al.cloud/patienten/patientenstamm/MST4PMPX-8M5AI
    Sleep    ${ACTION_DELAY}
    # Step 83: Fill input field 'input[role="combobox"]'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_34}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: ""
        END
        Fill Text    ${SELECTOR_TESTITEST_34}    
    END
    Sleep    ${ACTION_DELAY}
    # Step 84: Click element 'DIV'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_35}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_35}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_35}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 85: Click element 'INPUT'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_36}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_36}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_36}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 86: Fill input field '#mat-slide-toggle-1-input'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_36}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: "on"
        END
        Fill Text    ${SELECTOR_TESTITEST_36}    on
    END
    Sleep    ${ACTION_DELAY}
    # Step 87: Click element 'DIV'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_37}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_37}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_37}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 88: Click element 'INPUT'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_36}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_36}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_36}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 89: Fill input field '#mat-slide-toggle-1-input'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_36}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: "on"
        END
        Fill Text    ${SELECTOR_TESTITEST_36}    on
    END
    Sleep    ${ACTION_DELAY}
    # Step 90: Click element 'Speichern'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_29}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_29}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_29}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 91: Click element 'Speichern'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTITEST_29}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTITEST_29}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTITEST_29}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
