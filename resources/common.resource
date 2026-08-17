*** Settings ***
Documentation    Global setup, teardown and shared keywords for web testing.
Library          Browser
Library          ../libraries/visual_hud.py
Variables        ../variables/env_config.py

*** Keywords ***
Setup Web Test Browser
    [Documentation]    Initializes browser, context and navigates to target URL.
    [Arguments]        ${url}=about:blank
    ${is_headless}=    Evaluate    str('${HEADLESS}').upper() in ['TRUE', '1', 'YES', 'ON']
    New Browser        browser=${BROWSER}    headless=${is_headless}
    New Context        viewport={'width': 1280, 'height': 720}
    New Page           ${url}
    Set Browser Timeout    ${TIMEOUT}
    IF    not ${is_headless}
        Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
    END

Teardown Web Test Browser
    [Documentation]    Captures screenshot on failure and closes all browser instances.
    Run Keyword If Test Failed    Take Screenshot
    Close Browser      ALL

Navigate To URL
    [Documentation]    Navigates active page to a new URL.
    [Arguments]        ${url}
    Go To              ${url}
    ${is_headless}=    Evaluate    str('${HEADLESS}').upper() in ['TRUE', '1', 'YES', 'ON']
    IF    not ${is_headless}
        Run Keyword And Ignore Error    Inject Visual Pointer And Keystroke HUD
    END

