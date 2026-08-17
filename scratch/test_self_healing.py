import time
from Browser import Browser
from libraries.visual_hud import visual_hud

b = Browser()
b.new_browser(headless=True)
b.new_page("https://example.com")

v = visual_hud()

print("1. Injecting HUD and testing self-healing on show_keystroke_overlay...")
v.show_keystroke_overlay("Initial HUD Test")

# Check elements exist
res = b.evaluate_javascript(None, """() => {
    return {
        cursor: !!document.getElementById('py-web-tester-cursor'),
        hud: !!document.getElementById('py-web-tester-keystroke-hud')
    }
}""")
print("Elements after show_keystroke_overlay:", res)
assert res['cursor'] and res['hud'], "HUD elements not created"

print("2. Deleting HUD elements from DOM...")
b.evaluate_javascript(None, """() => {
    const c = document.getElementById('py-web-tester-cursor');
    if (c) c.remove();
    const h = document.getElementById('py-web-tester-keystroke-hud');
    if (h) h.remove();
}""")

res_deleted = b.evaluate_javascript(None, """() => {
    return {
        cursor: !!document.getElementById('py-web-tester-cursor'),
        hud: !!document.getElementById('py-web-tester-keystroke-hud')
    }
}""")
print("Elements after deletion:", res_deleted)
assert not res_deleted['cursor'] and not res_deleted['hud'], "HUD elements were not removed"

print("3. Triggering show_keystroke_overlay (should self-heal)...")
v.show_keystroke_overlay("Test Self-Healing Overlay")

res_healed = b.evaluate_javascript(None, """() => {
    const c = document.getElementById('py-web-tester-cursor');
    const h = document.getElementById('py-web-tester-keystroke-hud');
    return {
        cursor_exists: !!c,
        hud_exists: !!h,
        cursor_pe: c ? c.style.pointerEvents : '',
        cursor_zi: c ? c.style.zIndex : '',
        hud_pe: h ? h.style.pointerEvents : '',
        hud_zi: h ? h.style.zIndex : ''
    }
}""")
print("Elements after show_keystroke_overlay self-healing:", res_healed)
assert res_healed['cursor_exists'] and res_healed['hud_exists'], "Self-healing failed!"
assert res_healed['cursor_pe'] == 'none', "Cursor pointer-events missing"
assert res_healed['cursor_zi'] == '2147483647', "Cursor z-index wrong"
assert res_healed['hud_pe'] == 'none', "HUD overlay pointer-events missing"
assert res_healed['hud_zi'] == '2147483647', "HUD overlay z-index wrong"

print("4. Testing dynamic getBoundingClientRect animation...")
v.animate_visual_pointer("h1")

print("SUCCESS: All Self-Healing and CSS property checks PASSED!")
b.close_browser()
