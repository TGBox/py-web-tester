*** Settings ***
Library          Browser
Library          libraries/visual_hud.py

*** Test Cases ***
Test Visual HUD Overlay
    New Browser    browser=chromium    headless=False
    New Context    viewport={'width': 1280, 'height': 720}
    New Page       https://dr.data-al.cloud/aldashboard/login?returnUrl=%2Fhome
    Sleep          1s
    Show Keystroke Overlay    Eingabe: "admin@demo.de"
    Animate Visual Pointer To Element    input[type="password"]
    Sleep          4s
    Close Browser  ALL
