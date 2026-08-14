*** Settings ***
Documentation    Recorded test block routine for 'DataCur-Login-Instanz-DR'.
Library          Browser
Library          ../libraries/visual_hud.py

*** Variables ***
${DATACUR_LOGIN_INSTANZ_DR_START_URL}    https://dr.data-al.cloud
${ACTION_DELAY}                    150ms


*** Keywords ***
Execute Routine Datacur Login Instanz Dr
    [Documentation]    Executes recorded interaction sequence for DataCur-Login-Instanz-DR.
    [Arguments]        ${url}=${DATACUR_LOGIN_INSTANZ_DR_START_URL}
    Log    No interactive steps recorded.
