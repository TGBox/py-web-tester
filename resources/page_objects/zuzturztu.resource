*** Settings ***
Documentation    Recorded test block routine for 'zuzturztu'.
Library          Browser
Library          ../libraries/visual_hud.py

*** Variables ***
${ZUZTURZTU_START_URL}    https://dr.data-al.cloud
${ACTION_DELAY}                    300ms

${SELECTOR_ZUZTURZTU_1}                                         app-login.ng-star-inserted
${SELECTOR_ZUZTURZTU_2}                                         #mat-input-0
${SELECTOR_ZUZTURZTU_3}                                         #mat-input-1
${SELECTOR_ZUZTURZTU_4}                                         button:has-text("check")
${SELECTOR_ZUZTURZTU_5}                                         app-root > mat-sidenav-container > mat-sidenav-content > div > div > button > span > img
${SELECTOR_ZUZTURZTU_6}                                         button[aria-label="Toggle sidenav"]
${SELECTOR_ZUZTURZTU_7}                                         button:has-text("settings")
${SELECTOR_ZUZTURZTU_8}                                         span:has-text("Administrator")
${SELECTOR_ZUZTURZTU_9}                                         a:has-text("Logout Administrator")

*** Keywords ***
Execute Routine Zuzturztu
    [Documentation]    Executes recorded interaction sequence for zuzturztu.
    [Arguments]        ${url}=${ZUZTURZTU_START_URL}
    # Step 1: Navigate to 'https://dr.data-al.cloud/aldashboard/'
    Go To    https://dr.data-al.cloud/aldashboard/
    Sleep    ${ACTION_DELAY}
    # Step 2: Click element 'Anmelden E-Mail * Passwort * check'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ZUZTURZTU_1}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ZUZTURZTU_1}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ZUZTURZTU_1}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ZUZTURZTU_1}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 3: Fill input field '#mat-input-0'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ZUZTURZTU_2}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ZUZTURZTU_2}
    Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: "admin@demo.de"
    ${fill_ok}=    Run Keyword And Return Status    Fill Text    ${SELECTOR_ZUZTURZTU_2}    admin@demo.de
    Sleep    ${ACTION_DELAY}
    # Step 4: Fill input field '#mat-input-1'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ZUZTURZTU_3}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ZUZTURZTU_3}
    Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: "admin"
    ${fill_ok}=    Run Keyword And Return Status    Fill Text    ${SELECTOR_ZUZTURZTU_3}    admin
    Sleep    ${ACTION_DELAY}
    # Step 5: Click element 'check'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ZUZTURZTU_4}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ZUZTURZTU_4}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ZUZTURZTU_4}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ZUZTURZTU_4}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 6: Click element 'check'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ZUZTURZTU_4}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ZUZTURZTU_4}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ZUZTURZTU_4}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ZUZTURZTU_4}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 7: Click element 'IMG'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ZUZTURZTU_5}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ZUZTURZTU_5}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ZUZTURZTU_5}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ZUZTURZTU_5}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 8: Click element 'BUTTON'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ZUZTURZTU_6}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ZUZTURZTU_6}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ZUZTURZTU_6}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ZUZTURZTU_6}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 9: Click element 'settings'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ZUZTURZTU_7}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ZUZTURZTU_7}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ZUZTURZTU_7}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ZUZTURZTU_7}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 10: Click element 'Administrator'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ZUZTURZTU_8}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ZUZTURZTU_8}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ZUZTURZTU_8}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ZUZTURZTU_8}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 11: Click element 'Logout Administrator'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ZUZTURZTU_9}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ZUZTURZTU_9}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ZUZTURZTU_9}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ZUZTURZTU_9}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 12: Click element 'BUTTON'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ZUZTURZTU_6}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ZUZTURZTU_6}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ZUZTURZTU_6}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ZUZTURZTU_6}    force=True
    END
    Sleep    ${ACTION_DELAY}
