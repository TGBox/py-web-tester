*** Settings ***
Documentation    Recorded test block routine for 'asdfasdfasdf'.
Library          Browser
Library          ../libraries/visual_hud.py

*** Variables ***
${ASDFASDFASDF_START_URL}    https://dr.data-al.cloud
${ACTION_DELAY}                    150ms

${SELECTOR_ASDFASDFASDF_1}          #mat-input-1
${SELECTOR_ASDFASDFASDF_2}          mat-icon[role="img"]
${SELECTOR_ASDFASDFASDF_3}          button:has-text("check")
${SELECTOR_ASDFASDFASDF_4}          app-root > mat-sidenav-container > mat-sidenav-content > div > div > button > span > img
${SELECTOR_ASDFASDFASDF_5}          button[aria-label="Toggle sidenav"]
${SELECTOR_ASDFASDFASDF_6}          button:has-text("settings")
${SELECTOR_ASDFASDFASDF_7}          span:has-text("Administrator")
${SELECTOR_ASDFASDFASDF_8}          a:has-text("Logout Administrator")

*** Keywords ***
Execute Routine Asdfasdfasdf
    [Documentation]    Executes recorded interaction sequence for asdfasdfasdf.
    [Arguments]        ${url}=${ASDFASDFASDF_START_URL}
    # Step 1: Navigate to 'https://dr.data-al.cloud/aldashboard/'
    Go To    https://dr.data-al.cloud/aldashboard/
    Sleep    ${ACTION_DELAY}
    # Step 2: Click element 'INPUT'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_ASDFASDFASDF_1}    visible    timeout=3s
    IF    ${is_ready}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDFASDFASDF_1}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_ASDFASDFASDF_1}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 3: Fill input field '#mat-input-1'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_ASDFASDFASDF_1}    visible    timeout=3s
    IF    ${is_ready}
        Fill Text    ${SELECTOR_ASDFASDFASDF_1}    admin
    END
    Sleep    ${ACTION_DELAY}
    # Step 4: Click element 'check'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_ASDFASDFASDF_2}    visible    timeout=3s
    IF    ${is_ready}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDFASDFASDF_2}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_ASDFASDFASDF_2}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 5: Click element 'check'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_ASDFASDFASDF_3}    visible    timeout=3s
    IF    ${is_ready}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDFASDFASDF_3}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_ASDFASDFASDF_3}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 6: Click element 'IMG'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_ASDFASDFASDF_4}    visible    timeout=3s
    IF    ${is_ready}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDFASDFASDF_4}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_ASDFASDFASDF_4}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 7: Click element 'BUTTON'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_ASDFASDFASDF_5}    visible    timeout=3s
    IF    ${is_ready}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDFASDFASDF_5}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_ASDFASDFASDF_5}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 8: Click element 'settings'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_ASDFASDFASDF_6}    visible    timeout=3s
    IF    ${is_ready}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDFASDFASDF_6}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_ASDFASDFASDF_6}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 9: Click element 'Administrator'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_ASDFASDFASDF_7}    visible    timeout=3s
    IF    ${is_ready}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDFASDFASDF_7}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_ASDFASDFASDF_7}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 10: Click element 'Logout Administrator'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_ASDFASDFASDF_8}    visible    timeout=3s
    IF    ${is_ready}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDFASDFASDF_8}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_ASDFASDFASDF_8}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
    # Step 11: Click element 'BUTTON'
    ${is_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SELECTOR_ASDFASDFASDF_5}    visible    timeout=3s
    IF    ${is_ready}
        ${click_ok}=    Run Keyword And Return Status    Click    ${SELECTOR_ASDFASDFASDF_5}
        IF    not ${click_ok}
            Run Keyword And Ignore Error    Click    ${SELECTOR_ASDFASDFASDF_5}    force=True
        END
    END
    Sleep    ${ACTION_DELAY}
