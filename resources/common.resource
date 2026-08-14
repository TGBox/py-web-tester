*** Settings ***
Documentation    Global setup, teardown and shared keywords for web testing.
Library          Browser
Library          ../libraries/visual_hud.py
Variables        ../variables/env_config.py

*** Keywords ***
Setup Web Test Browser
    [Documentation]    Initializes browser, context and navigates to target URL.
    [Arguments]        ${url}=${BASE_URL}
    New Browser        browser=${BROWSER}    headless=${HEADLESS}
    New Context        viewport={'width': 1280, 'height': 720}
    New Page           ${url}
    Set Browser Timeout    ${TIMEOUT}
    IF    $HEADLESS is False or str($HEADLESS).upper() == 'FALSE'
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
