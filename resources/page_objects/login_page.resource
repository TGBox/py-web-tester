*** Settings ***
Documentation    Page Object representing a standard Web Login Form.
Library          Browser
Variables        ../../variables/env_config.py

*** Variables ***
${USERNAME_INPUT}    id=username
${PASSWORD_INPUT}    id=password
${SUBMIT_BTN}        css=button[type="submit"]
${FLASH_MSG}         id=flash
${LOGOUT_BTN}        css=a[href="/logout"]

*** Keywords ***
Open Login Page
    [Documentation]    Navigates to the login page URL.
    Go To    ${LOGIN_URL}

Perform Login
    [Documentation]    Fills username and password and submits form.
    [Arguments]        ${username}    ${password}
    Fill Text          ${USERNAME_INPUT}    ${username}
    Fill Secret        ${PASSWORD_INPUT}    $password
    Click              ${SUBMIT_BTN}

Verify Successful Login Message
    [Documentation]    Verifies that the flash message indicates successful login.
    Get Text           ${FLASH_MSG}    contains    You logged into a secure area!
    Get Element States    ${LOGOUT_BTN}    contains    visible

Verify Failed Login Message
    [Documentation]    Verifies login error message for invalid credentials.
    Get Text           ${FLASH_MSG}    contains    Your username is invalid!
