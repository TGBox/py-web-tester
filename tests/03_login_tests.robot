*** Settings ***
Documentation    Authentication and Form Interaction Tests.
Resource         ../resources/common.resource
Resource         ../resources/page_objects/login_page.resource
Variables        ../variables/env_config.py

Test Setup       Setup Web Test Browser    url=${LOGIN_URL}
Test Teardown    Teardown Web Test Browser

*** Test Cases ***
User Can Successfully Log In With Valid Credentials
    [Documentation]    Verifies successful login flow with valid credentials.
    [Tags]             login    smoke    regression
    Perform Login      ${DEMO_USER}    ${DEMO_PASSWORD}
    Verify Successful Login Message

User Sees Error Message With Invalid Credentials
    [Documentation]    Verifies error handling for wrong login details.
    [Tags]             login    negative
    Perform Login      invalidUser    wrongPassword123
    Verify Failed Login Message
