*** Settings ***
Documentation    Recorded test block routine for 'asdf'.
Library          Browser
Library          ../libraries/visual_hud.py

*** Variables ***
${ASDF_START_URL}    https://dr.data-al.cloud/aldashboard/login?returnUrl=%2Fhome
${ACTION_DELAY}                    300ms

${SELECTOR_ASDF_1}                                              app-root > mat-sidenav-container > mat-sidenav-content > div > div:nth-of-type(2) > app-login
${SELECTOR_ASDF_2}                                              mat-form-field#email > div > div > div > input
${SELECTOR_ASDF_3}                                              input[type="password"]
${SELECTOR_ASDF_4}                                              mat-icon[role="img"]
${SELECTOR_ASDF_5}                                              button:has-text("check")
${SELECTOR_ASDF_6}                                              app-root > mat-sidenav-container > mat-sidenav-content > div > div > button > span > img
${SELECTOR_ASDF_7}                                              button[aria-label="Toggle sidenav"]
${SELECTOR_ASDF_8}                                              button:has-text("settings")
${SELECTOR_ASDF_9}                                              span:has-text("Administrator")
${SELECTOR_ASDF_10}                                             a:has-text("Logout Administrator")

*** Keywords ***
Execute Routine Asdf
    [Documentation]    Executes recorded interaction sequence for asdf.
    [Arguments]        ${url}=${ASDF_START_URL}
    # Step 1: Navigate to 'https://dr.data-al.cloud/aldashboard/login?returnUrl=%2Fhome'
    Go To    https://dr.data-al.cloud/aldashboard/login?returnUrl=%2Fhome
    Sleep    ${ACTION_DELAY}
    # Step 2: Klick auf Element 'Anmelden E-Mail * Passwort * check'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDF_1}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDF_1}
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDF_1}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ASDF_1}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 3: Fill input field 'mat-form-field#email > div > div > div > input'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDF_2}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDF_2}
    Sleep    150ms
    Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: "admin@demo.de"
    Run Keyword And Ignore Error    Click    ${SELECTOR_ASDF_2}
    ${type_ok}=    Run Keyword And Return Status    Type Text    ${SELECTOR_ASDF_2}    admin@demo.de    delay=40ms
    IF    not ${type_ok}
        Run Keyword And Ignore Error    Fill Text    ${SELECTOR_ASDF_2}    admin@demo.de
    END
    Sleep    ${ACTION_DELAY}
    # Step 4: Fill input field 'input[type="password"]'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDF_3}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDF_3}
    Sleep    150ms
    Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: "admin"
    Run Keyword And Ignore Error    Click    ${SELECTOR_ASDF_3}
    ${type_ok}=    Run Keyword And Return Status    Type Text    ${SELECTOR_ASDF_3}    admin    delay=40ms
    IF    not ${type_ok}
        Run Keyword And Ignore Error    Fill Text    ${SELECTOR_ASDF_3}    admin
    END
    Sleep    ${ACTION_DELAY}
    # Step 5: Klick auf Element 'check'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDF_4}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDF_4}
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDF_4}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ASDF_4}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 6: Click element 'check'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDF_5}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDF_5}
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDF_5}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ASDF_5}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 7: Klick auf Element 'IMG'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDF_6}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDF_6}
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDF_6}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ASDF_6}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 8: Click element 'BUTTON'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDF_7}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDF_7}
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDF_7}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ASDF_7}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 9: Click element 'settings'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDF_8}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDF_8}
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDF_8}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ASDF_8}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 10: Klick auf Element 'Administrator'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDF_9}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDF_9}
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDF_9}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ASDF_9}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 11: Click element 'Logout Administrator'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDF_10}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDF_10}
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDF_10}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ASDF_10}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 12: Click element 'BUTTON'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDF_7}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDF_7}
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDF_7}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ASDF_7}    force=True
    END
    Sleep    ${ACTION_DELAY}
