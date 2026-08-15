*** Settings ***
Documentation    Recorded test block routine for 'asdfasdf'.
Library          Browser
Library          ../libraries/visual_hud.py

*** Variables ***
${ASDFASDF_START_URL}    https://dr.data-al.cloud
${ACTION_DELAY}                    300ms

${SELECTOR_ASDFASDF_1}                                          app-root > mat-sidenav-container > mat-sidenav-content > div > div:nth-of-type(2) > app-login
${SELECTOR_ASDFASDF_2}                                          mat-form-field#email > div > div > div > input
${SELECTOR_ASDFASDF_3}                                          input[type="password"]

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
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDFASDF_1}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ASDFASDF_1}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 3: Fill input field 'mat-form-field#email > div > div > div > input'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDFASDF_2}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDFASDF_2}
    Sleep    150ms
    Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: "asdfasdfasdfasd"
    Run Keyword And Ignore Error    Click    ${SELECTOR_ASDFASDF_2}
    ${fill_ok}=    Run Keyword And Return Status    Fill Text    ${SELECTOR_ASDFASDF_2}    asdfasdfasdfasd
    IF    not ${fill_ok}
        Run Keyword And Ignore Error    Type Text    ${SELECTOR_ASDFASDF_2}    asdfasdfasdfasd
    END
    Sleep    ${ACTION_DELAY}
    # Step 4: Click element 'Anmelden E-Mail * Passwort * check'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDFASDF_1}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDFASDF_1}
    Sleep    150ms
    ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDFASDF_1}
    IF    not ${click_ok}
        Run Keyword And Ignore Error    Click    ${SELECTOR_ASDFASDF_1}    force=True
    END
    Sleep    ${ACTION_DELAY}
    # Step 5: Fill input field 'input[type="password"]'
    Run Keyword And Ignore Error    Wait For Elements State    ${SELECTOR_ASDFASDF_3}    visible    timeout=5s
    Run Keyword And Ignore Error    Animate Visual Pointer To Element    ${SELECTOR_ASDFASDF_3}
    Sleep    150ms
    Run Keyword And Ignore Error    Show Keystroke Overlay    Eingabe: "qwerqwer"
    Run Keyword And Ignore Error    Click    ${SELECTOR_ASDFASDF_3}
    ${fill_ok}=    Run Keyword And Return Status    Fill Text    ${SELECTOR_ASDFASDF_3}    qwerqwer
    IF    not ${fill_ok}
        Run Keyword And Ignore Error    Type Text    ${SELECTOR_ASDFASDF_3}    qwerqwer
    END
    Sleep    ${ACTION_DELAY}
