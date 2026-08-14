*** Settings ***
Documentation    Recorded test block routine for 'DataCur-Login-Instanz-DR'.
Library          Browser

*** Variables ***
${DATACUR-LOGIN-INSTANZ-DR_START_URL}    https://dr.data-al.cloud


*** Keywords ***
Execute Routine Datacur-Login-Instanz-Dr
    [Documentation]    Executes recorded interaction sequence for DataCur-Login-Instanz-DR.
    [Arguments]        ${url}=${DATACUR-LOGIN-INSTANZ-DR_START_URL}
    Log    No interactive steps recorded.
