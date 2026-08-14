*** Settings ***
Documentation    Recorded test block routine for 'teste'.
Library          Browser
Library          ../libraries/visual_hud.py

*** Variables ***
${TESTE_START_URL}    https://dr.data-al.cloud
${ACTION_DELAY}                    150ms

${SELECTOR_TESTE_1}                 mat-icon[role="img"]
${SELECTOR_TESTE_2}                 button:has-text("check")
${SELECTOR_TESTE_3}                 span:has-text("people Patientenstamm")
${SELECTOR_TESTE_4}                 input[role="combobox"]
${SELECTOR_TESTE_5}                 span:has-text("Mustermann, Max 01.01.2000")
${SELECTOR_TESTE_6}                 #\[object\ Object\]
${SELECTOR_TESTE_7}                 app-root > mat-sidenav-container > mat-sidenav-content > div > div > button > span > img
${SELECTOR_TESTE_8}                 button[aria-label="Toggle sidenav"]
${SELECTOR_TESTE_9}                 button:has-text("dashboard")
${SELECTOR_TESTE_10}                button:has-text("calendar_month")
${SELECTOR_TESTE_11}                app-root > mat-sidenav-container > mat-sidenav-content > div > div:nth-of-type(2) > eventcalendar > mat-drawer-container > mat-drawer-content > div > div:nth-of-type(2) > mbsc-eventcalendar > mbsc-calendar-view > mbsc-scheduler > div:nth-of-type(3) > div:nth-of-type(2) > div > div > div > div:nth-of-type(3) > div > div:nth-of-type(54)
${SELECTOR_TESTE_12}                span:has-text("18:45 - 19:00")
${SELECTOR_TESTE_13}                app-root > mat-sidenav-container > mat-sidenav-content > div > div:nth-of-type(2) > eventcalendar > mat-drawer-container > mat-drawer-content > div > div:nth-of-type(2) > mbsc-eventcalendar > mbsc-calendar-view > mbsc-scheduler > div:nth-of-type(3) > div:nth-of-type(2) > div > div > div > div:nth-of-type(3) > div > div > mbsc-schedule-event:nth-of-type(5)
${SELECTOR_TESTE_14}                #mat-dialog-0
${SELECTOR_TESTE_15}                button:has-text("Löschen")
${SELECTOR_TESTE_16}                #mat-checkbox-9-input
${SELECTOR_TESTE_17}                span:has-text("Löschen")

*** Keywords ***
Execute Routine Teste
    [Documentation]    Executes recorded interaction sequence for teste.
    [Arguments]        ${url}=${TESTE_START_URL}
    # Step 1: Navigate to 'https://dr.data-al.cloud/aldashboard/'
    Go To    https://dr.data-al.cloud/aldashboard/
    Sleep    ${ACTION_DELAY}
    # Step 2: Navigate to 'https://dr.data-al.cloud/aldashboard/login?returnUrl=%2Fhome'
    Go To    https://dr.data-al.cloud/aldashboard/login?returnUrl=%2Fhome
    Sleep    ${ACTION_DELAY}
    # Step 3: Click element 'check'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTE_1}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TESTE_1}
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTE_1}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTE_1}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 4: Click element 'check'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTE_2}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TESTE_2}
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTE_2}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTE_2}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 5: Navigate to 'https://dr.data-al.cloud/aldashboard/home'
    Go To    https://dr.data-al.cloud/aldashboard/home
    Sleep    ${ACTION_DELAY}
    # Step 6: Click element 'people Patientenstamm'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTE_3}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TESTE_3}
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTE_3}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTE_3}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 7: Navigate to 'https://dr.data-al.cloud/patienten/'
    Go To    https://dr.data-al.cloud/patienten/
    Sleep    ${ACTION_DELAY}
    # Step 8: Navigate to 'https://dr.data-al.cloud/patienten/patientenstamm'
    Go To    https://dr.data-al.cloud/patienten/patientenstamm
    Sleep    ${ACTION_DELAY}
    # Step 9: Click element 'INPUT'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTE_4}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TESTE_4}
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTE_4}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTE_4}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 10: Fill input field 'input[role="combobox"]'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTE_4}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TESTE_4}
        END
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: "mustermann"
        END
        Fill Text    ${SELECTOR_TESTE_4}    mustermann
    END
    Sleep    ${ACTION_DELAY}
    # Step 11: Click element 'Mustermann, Max 01.01.2000'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTE_5}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TESTE_5}
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTE_5}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTE_5}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 12: Click element 'Mustermann, Max 01.01.2000'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTE_6}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TESTE_6}
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTE_6}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTE_6}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 13: Fill input field 'input[role="combobox"]'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTE_4}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TESTE_4}
        END
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: ""
        END
        Fill Text    ${SELECTOR_TESTE_4}    
    END
    Sleep    ${ACTION_DELAY}
    # Step 14: Navigate to 'https://dr.data-al.cloud/patienten/patientenstamm/MST4PMPX-8M5AI'
    Go To    https://dr.data-al.cloud/patienten/patientenstamm/MST4PMPX-8M5AI
    Sleep    ${ACTION_DELAY}
    # Step 15: Fill input field 'input[role="combobox"]'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTE_4}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TESTE_4}
        END
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: ""
        END
        Fill Text    ${SELECTOR_TESTE_4}    
    END
    Sleep    ${ACTION_DELAY}
    # Step 16: Click element 'IMG'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTE_7}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TESTE_7}
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTE_7}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTE_7}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 17: Click element 'BUTTON'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTE_8}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TESTE_8}
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTE_8}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTE_8}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 18: Click element 'dashboard'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTE_9}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TESTE_9}
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTE_9}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTE_9}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 19: Click element 'calendar_month'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTE_10}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TESTE_10}
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTE_10}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTE_10}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 20: Navigate to 'https://dr.data-al.cloud/terminplaner/event?patientid=MST4PMPX-8M5AI'
    Go To    https://dr.data-al.cloud/terminplaner/event?patientid=MST4PMPX-8M5AI
    Sleep    ${ACTION_DELAY}
    # Step 21: Click element 'DIV'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTE_11}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TESTE_11}
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTE_11}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTE_11}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 22: Click element 'DIV'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTE_11}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TESTE_11}
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTE_11}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTE_11}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 23: Click element 'DIV'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTE_11}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TESTE_11}
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTE_11}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTE_11}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 24: Click element '18:45 - 19:00'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTE_12}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TESTE_12}
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTE_12}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTE_12}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 25: Click element 'Mustermann Max Behandlung 18:45 - 19:00'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTE_13}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TESTE_13}
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTE_13}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTE_13}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 26: Click element 'Termin bearbeiten help_outline Umwandeln zu Gruppentermin Zum Patienten Termin (Leistung) help_outli'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTE_14}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TESTE_14}
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTE_14}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTE_14}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 27: Click element 'Löschen'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTE_15}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TESTE_15}
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTE_15}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTE_15}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 28: Click element 'Löschen'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTE_15}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TESTE_15}
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTE_15}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTE_15}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 29: Click element 'Mustermann Max Behandlung 18:45 - 19:00'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTE_13}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TESTE_13}
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTE_13}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTE_13}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 30: Fill input field '#mat-checkbox-9-input'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTE_16}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TESTE_16}
        END
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: "on"
        END
        Fill Text    ${SELECTOR_TESTE_16}    on
    END
    Sleep    ${ACTION_DELAY}
    # Step 31: Click element 'Löschen'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTE_17}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TESTE_17}
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTE_17}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTE_17}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 32: Click element 'Löschen'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTE_15}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TESTE_15}
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTE_15}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTE_15}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 33: Click element 'Mustermann Max Behandlung 18:45 - 19:00'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_TESTE_13}    visible    timeout=3s
    IF    ${is_ready}
        IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
            Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_TESTE_13}
        END
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_TESTE_13}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_TESTE_13}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
