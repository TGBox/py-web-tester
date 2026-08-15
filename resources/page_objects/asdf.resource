*** Settings ***
Documentation    Recorded test block routine for 'asdf'.
Library          Browser
Library          ../libraries/visual_hud.py

*** Variables ***
${ASDF_START_URL}    https://dr.data-al.cloud
${ACTION_DELAY}                    300ms

${SELECTOR_ASDF_1}                                              app-login.ng-star-inserted
${SELECTOR_ASDF_2}                                              #mat-input-0
${SELECTOR_ASDF_3}                                              #mat-input-1
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
    # Step 1: Navigate to 'https://dr.data-al.cloud/aldashboard/'
    Go To    https://dr.data-al.cloud/aldashboard/
    Sleep    ${ACTION_DELAY}
    # Step 2: Click element 'Anmelden E-Mail * Passwort * check'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDF_1}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDF_1}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDF_1}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ASDF_1}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 3: Fill input field '#mat-input-0'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDF_2}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDF_2}
    Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: "admin@demo.de"
    ${fill_ok}=    Run Keyword And Return Status    Fill Text    ${SELECTOR_ASDF_2}    admin@demo.de
    Sleep    ${ACTION_DELAY}
    # Step 4: Fill input field '#mat-input-1'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDF_3}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDF_3}
    Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: "admin"
    ${fill_ok}=    Run Keyword And Return Status    Fill Text    ${SELECTOR_ASDF_3}    admin
    Sleep    ${ACTION_DELAY}
    # Step 5: Click element 'check'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDF_4}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDF_4}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDF_4}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ASDF_4}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 6: Click element 'check'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDF_5}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDF_5}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDF_5}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ASDF_5}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 7: Click element 'IMG'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDF_6}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDF_6}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDF_6}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ASDF_6}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 8: Click element 'BUTTON'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDF_7}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDF_7}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDF_7}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ASDF_7}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 9: Click element 'settings'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDF_8}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDF_8}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDF_8}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ASDF_8}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 10: Click element 'Administrator'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDF_9}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDF_9}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDF_9}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ASDF_9}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 11: Click element 'Logout Administrator'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDF_10}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDF_10}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDF_10}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ASDF_10}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 12: Click element 'BUTTON'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDF_7}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDF_7}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDF_7}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ASDF_7}    force=True
    END
    Sleep    ${ACTION_DELAY}
