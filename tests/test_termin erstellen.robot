*** Settings ***
Documentation    Automated test execution suite for recorded routine 'termin erstellen'.
Resource         ../resources/common.resource
Resource         ../resources/page_objects/termin erstellen.resource
Test Setup       Setup Web Test Browser
Test Teardown    Teardown Web Test Browser

*** Test Cases ***
Verify Recorded Routine Block Termin Erstellen
    [Documentation]    Runs recorded user interactions as a test block.
    [Tags]             routine    recorded
    Execute Routine Termin Erstellen

