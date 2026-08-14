*** Settings ***
Documentation    Recorded test block routine for 'Login und Logout'.
Library          Browser
Library          ../libraries/visual_hud.py

*** Variables ***
${LOGIN_UND_LOGOUT_START_URL}    https://dr.data-al.cloud
${ACTION_DELAY}                    300ms

${SELECTOR_LOGIN_UND_LOGOUT_1}                                  #mat-input-0
${SELECTOR_LOGIN_UND_LOGOUT_2}                                  app-login.ng-star-inserted
${SELECTOR_LOGIN_UND_LOGOUT_3}                                  #mat-input-1
${SELECTOR_LOGIN_UND_LOGOUT_4}                                  mat-icon[role="img"]
${SELECTOR_LOGIN_UND_LOGOUT_5}                                  button:has-text("check")
${SELECTOR_LOGIN_UND_LOGOUT_6}                                  app-root > mat-sidenav-container > mat-sidenav-content > div > div > button > span > img
${SELECTOR_LOGIN_UND_LOGOUT_7}                                  button[aria-label="Toggle sidenav"]
${SELECTOR_LOGIN_UND_LOGOUT_8}                                  button:has-text("settings")
${SELECTOR_LOGIN_UND_LOGOUT_9}                                  span:has-text("Administrator")
${SELECTOR_LOGIN_UND_LOGOUT_10}                                 a:has-text("Logout Administrator")

*** Keywords ***
Execute Routine Login Und Logout
    [Documentation]    Executes recorded interaction sequence for Login und Logout.
    [Arguments]        ${url}=${LOGIN_UND_LOGOUT_START_URL}
    # Step 1: Navigate to 'https://dr.data-al.cloud/aldashboard/'
    Go To    https://dr.data-al.cloud/aldashboard/
    Sleep    ${ACTION_DELAY}
    # Step 2: Click element 'INPUT'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_UND_LOGOUT_1}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_UND_LOGOUT_1}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_UND_LOGOUT_1}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_UND_LOGOUT_1}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 3: Click element 'Anmelden E-Mail * Passwort * check'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_UND_LOGOUT_2}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_UND_LOGOUT_2}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_UND_LOGOUT_2}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_UND_LOGOUT_2}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 4: Fill input field '#mat-input-0'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_UND_LOGOUT_1}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_UND_LOGOUT_1}
    Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: "admin@demo.de"
    ${fill_ok}=    Run Keyword And Return Status    Fill Text    ${SELECTOR_LOGIN_UND_LOGOUT_1}    admin@demo.de
    Sleep    ${ACTION_DELAY}
    # Step 5: Fill input field '#mat-input-1'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_UND_LOGOUT_3}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_UND_LOGOUT_3}
    Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: "admin"
    ${fill_ok}=    Run Keyword And Return Status    Fill Text    ${SELECTOR_LOGIN_UND_LOGOUT_3}    admin
    Sleep    ${ACTION_DELAY}
    # Step 6: Click element 'check'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_UND_LOGOUT_4}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_UND_LOGOUT_4}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_UND_LOGOUT_4}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_UND_LOGOUT_4}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 7: Click element 'check'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_UND_LOGOUT_5}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_UND_LOGOUT_5}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_UND_LOGOUT_5}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_UND_LOGOUT_5}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 8: Click element 'IMG'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_UND_LOGOUT_6}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_UND_LOGOUT_6}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_UND_LOGOUT_6}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_UND_LOGOUT_6}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 9: Click element 'BUTTON'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_UND_LOGOUT_7}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_UND_LOGOUT_7}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_UND_LOGOUT_7}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_UND_LOGOUT_7}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 10: Click element 'settings'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_UND_LOGOUT_8}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_UND_LOGOUT_8}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_UND_LOGOUT_8}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_UND_LOGOUT_8}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 11: Click element 'Administrator'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_UND_LOGOUT_9}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_UND_LOGOUT_9}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_UND_LOGOUT_9}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_UND_LOGOUT_9}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 12: Click element 'Logout Administrator'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_UND_LOGOUT_10}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_UND_LOGOUT_10}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_UND_LOGOUT_10}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_UND_LOGOUT_10}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 13: Click element 'BUTTON'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_LOGIN_UND_LOGOUT_7}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_LOGIN_UND_LOGOUT_7}
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_LOGIN_UND_LOGOUT_7}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_LOGIN_UND_LOGOUT_7}    force=True
    END
    Sleep    ${ACTION_DELAY}
