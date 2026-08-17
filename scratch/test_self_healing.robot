*** Settings ***
Library          Browser
Library          ../libraries/visual_hud.py

*** Test Cases ***
Verify Visual HUD Self Healing And CSS Rules
    New Browser    browser=chromium    headless=True
    New Page       https://example.com

    Log    1. Injecting HUD and testing Show Keystroke Overlay
    Show Keystroke Overlay    Test Self-Healing Overlay
    ${c1}=    Get Element Count    id=py-web-tester-cursor
    ${h1}=    Get Element Count    id=py-web-tester-keystroke-hud
    Should Be Equal As Integers    ${c1}    1
    Should Be Equal As Integers    ${h1}    1

    Log    2. Deleting HUD elements from DOM
    Evaluate JavaScript    css=body    (el) => { const c = document.getElementById('py-web-tester-cursor'); if (c) c.remove(); const h = document.getElementById('py-web-tester-keystroke-hud'); if (h) h.remove(); }
    ${c2}=    Get Element Count    id=py-web-tester-cursor
    ${h2}=    Get Element Count    id=py-web-tester-keystroke-hud
    Should Be Equal As Integers    ${c2}    0
    Should Be Equal As Integers    ${h2}    0

    Log    3. Triggering Show Keystroke Overlay to test self-healing
    Show Keystroke Overlay    Self-Healed HUD Text
    ${c3}=    Get Element Count    id=py-web-tester-cursor
    ${h3}=    Get Element Count    id=py-web-tester-keystroke-hud
    Should Be Equal As Integers    ${c3}    1
    Should Be Equal As Integers    ${h3}    1

    ${cursor_pe}=    Get Style    id=py-web-tester-cursor          pointer-events
    ${cursor_zi}=    Get Style    id=py-web-tester-cursor          z-index
    ${hud_pe}=       Get Style    id=py-web-tester-keystroke-hud    pointer-events
    ${hud_zi}=       Get Style    id=py-web-tester-keystroke-hud    z-index

    Should Be Equal    ${cursor_pe}    none
    Should Be Equal    ${cursor_zi}    2147483647
    Should Be Equal    ${hud_pe}       none
    Should Be Equal    ${hud_zi}       2147483647

    Log    4. Testing dynamic getBoundingClientRect animation
    Animate Visual Pointer To Element    h1

    Close Browser    ALL
