*** Settings ***
Documentation    Recorded test block routine for 'test'.
Library          Browser
Library          ../libraries/visual_hud.py

*** Variables ***
${TEST_START_URL}    https://dr.data-al.cloud
${ACTION_DELAY}                    150ms

${SELECTOR_TEST_1}                  mat-icon[role="img"]
${SELECTOR_TEST_2}                  button:has-text("check")
${SELECTOR_TEST_3}                  span:has-text("calendar_month Terminplaner")
${SELECTOR_TEST_4}                  #mat-input-0
${SELECTOR_TEST_5}                  span:has-text("Mustermann, Max 01.01.2000")
${SELECTOR_TEST_6}                  #\[object\ Object\]
${SELECTOR_TEST_7}                  app-root > mat-sidenav-container > mat-sidenav-content > div > div:nth-of-type(2) > eventcalendar > picker-calendar > div > div > div > div:nth-of-type(10) > img
${SELECTOR_TEST_8}                  app-root > mat-sidenav-container > mat-sidenav-content > div > div:nth-of-type(2) > eventcalendar > mat-drawer-container > mat-drawer-content > div > div:nth-of-type(2) > mbsc-eventcalendar > mbsc-calendar-view > mbsc-scheduler > div:nth-of-type(3) > div:nth-of-type(2) > div > div > div > div:nth-of-type(3) > div > div:nth-of-type(52)
${SELECTOR_TEST_9}                  app-root > mat-sidenav-container > mat-sidenav-content > div > div:nth-of-type(2) > eventcalendar > mat-drawer-container > mat-drawer-content > div > div:nth-of-type(2) > mbsc-eventcalendar > mbsc-calendar-view > mbsc-scheduler > div:nth-of-type(3) > div:nth-of-type(2) > div > div > div > div:nth-of-type(3) > div > div:nth-of-type(51)
${SELECTOR_TEST_10}                 app-root > mat-sidenav-container > mat-sidenav-content > div > div:nth-of-type(2) > eventcalendar > mat-drawer-container > mat-drawer-content > div > div:nth-of-type(2) > mbsc-eventcalendar > mbsc-calendar-view > mbsc-scheduler > div:nth-of-type(3) > div:nth-of-type(2) > div > div > div > div:nth-of-type(3) > div > div > mbsc-schedule-event:nth-of-type(8) > div:nth-of-type(3) > div:nth-of-type(3)
${SELECTOR_TEST_11}                 app-root > mat-sidenav-container > mat-sidenav-content > div > div:nth-of-type(2) > eventcalendar > mat-drawer-container > mat-drawer-content > div > div:nth-of-type(2) > mbsc-eventcalendar > mbsc-calendar-view > mbsc-scheduler > div:nth-of-type(3) > div:nth-of-type(2) > div > div > div > div:nth-of-type(3) > div > div > mbsc-schedule-event:nth-of-type(8)
${SELECTOR_TEST_12}                 #mat-dialog-0
${SELECTOR_TEST_13}                 span:has-text("Löschen")
${SELECTOR_TEST_14}                 button:has-text("Löschen")
${SELECTOR_TEST_15}                 #mat-checkbox-9-input

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
    # Step 3: Click element 'check'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TEST_1}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_1}
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_1}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_1}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 4: Click element 'check'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TEST_2}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_2}
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_2}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_2}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 5: Navigate to 'https://dr.data-al.cloud/aldashboard/home'
    Go To    https://dr.data-al.cloud/aldashboard/home
    Sleep    ${ACTION_DELAY}
    # Step 6: Click element 'calendar_month Terminplaner'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TEST_3}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_3}
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_3}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_3}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 7: Navigate to 'https://dr.data-al.cloud/terminplaner/'
    Go To    https://dr.data-al.cloud/terminplaner/
    Sleep    ${ACTION_DELAY}
    # Step 8: Navigate to 'https://dr.data-al.cloud/terminplaner/event'
    Go To    https://dr.data-al.cloud/terminplaner/event
    Sleep    ${ACTION_DELAY}
    # Step 9: Click element 'INPUT'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TEST_4}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_4}
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_4}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_4}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 10: Fill input field '#mat-input-0'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TEST_4}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_4}
        END
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: "muster"
        END
        Fill Text    ${SELECTOR_TEST_4}    muster
    END
    Sleep    ${ACTION_DELAY}
    # Step 11: Click element 'Mustermann, Max 01.01.2000'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TEST_5}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_5}
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_5}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_5}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 12: Click element 'Mustermann, Max 01.01.2000'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TEST_6}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_6}
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_6}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_6}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 13: Fill input field '#mat-input-0'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TEST_4}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_4}
        END
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: "Mustermann Max 01.01.2000"
        END
        Fill Text    ${SELECTOR_TEST_4}    Mustermann Max 01.01.2000
    END
    Sleep    ${ACTION_DELAY}
    # Step 14: Click element 'IMG'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TEST_7}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_7}
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_7}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_7}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 15: Click element 'IMG'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TEST_7}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_7}
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_7}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_7}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 16: Click element 'DIV'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TEST_8}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_8}
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_8}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_8}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 17: Click element 'DIV'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TEST_8}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_8}
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_8}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_8}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 18: Click element 'DIV'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TEST_8}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_8}
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_8}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_8}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 19: Click element 'DIV'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TEST_9}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_9}
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_9}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_9}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 20: Click element 'Behandlung 18:15 - 18:30'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TEST_10}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_10}
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_10}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_10}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 21: Click element 'Mustermann Max Behandlung 18:15 - 18:30'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TEST_11}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_11}
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_11}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_11}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 22: Click element 'Termin bearbeiten help_outline Umwandeln zu Gruppentermin Zum Patienten Termin (Leistung) help_outli'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TEST_12}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_12}
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_12}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_12}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 23: Click element 'Löschen'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TEST_13}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_13}
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_13}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_13}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 24: Click element 'Löschen'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TEST_14}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_14}
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_14}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_14}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 25: Click element 'Mustermann Max Behandlung 18:15 - 18:30'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TEST_11}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_11}
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_11}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_11}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 26: Fill input field '#mat-checkbox-9-input'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TEST_15}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_15}
        END
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: "on"
        END
        Fill Text    ${SELECTOR_TEST_15}    on
    END
    Sleep    ${ACTION_DELAY}
    # Step 27: Click element 'Löschen'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TEST_13}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_13}
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_13}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_13}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 28: Click element 'Löschen'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TEST_14}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_14}
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_14}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_14}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 29: Click element 'Mustermann Max Behandlung 18:15 - 18:30'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TEST_11}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TEST_11}
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TEST_11}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TEST_11}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
