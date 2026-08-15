import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent.parent))

import time
from robot.libraries.BuiltIn import BuiltIn
from Browser import Browser
from libraries.visual_hud import visual_hud

b = Browser()
b.new_browser(headless=False)
b.new_page("https://dr.data-al.cloud/aldashboard/login?returnUrl=%2Fhome")

v = visual_hud()

# Wait for page load
time.sleep(2)

print("--- Testing show_keystroke_overlay ---")
v.show_keystroke_overlay("Eingabe: admin@demo.de")

print("--- Testing animate_visual_pointer ---")
v.animate_visual_pointer("input[type=\"password\"]")

time.sleep(5)
b.close_browser()
