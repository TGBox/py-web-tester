"""
Visual HUD Helper for py-web-tester.
Injects a visual mouse pointer cursor and a bottom-screen Keystroke HUD overlay
during Headed test execution so users can clearly see clicks, cursor movements, and typed text.
Provides smooth cursor animation to target elements during automated Playwright steps.
"""

import json
from robot.api.deco import keyword
from robot.libraries.BuiltIn import BuiltIn

VISUAL_HUD_SCRIPT = """
(function() {
    if (window.__PY_VISUAL_HUD_INJECTED__) return;
    window.__PY_VISUAL_HUD_INJECTED__ = true;

    // 1. Create Visual Mouse Pointer Overlay
    let cursor = document.getElementById('py-web-tester-cursor');
    if (!cursor) {
        cursor = document.createElement('div');
        cursor.id = 'py-web-tester-cursor';
        cursor.style.cssText = `
            position: fixed;
            top: 50%;
            left: 50%;
            width: 24px;
            height: 24px;
            border-radius: 50%;
            background: rgba(255, 0, 110, 0.85);
            border: 2px solid #ffffff;
            box-shadow: 0 0 14px rgba(255, 0, 110, 0.95), 0 0 6px #000;
            pointer-events: none;
            z-index: 2147483647;
            transition: left 0.2s ease-out, top 0.2s ease-out, transform 0.1s ease;
            transform: translate(-50%, -50%);
            display: block;
        `;
        const dot = document.createElement('div');
        dot.style.cssText = 'width:6px; height:6px; background:#fff; border-radius:50%; margin:7px auto;';
        cursor.appendChild(dot);
        (document.body || document.documentElement).appendChild(cursor);
    }

    // 2. Create Bottom Keystroke HUD Overlay
    let hud = document.getElementById('py-web-tester-keystroke-hud');
    if (!hud) {
        hud = document.createElement('div');
        hud.id = 'py-web-tester-keystroke-hud';
        hud.style.cssText = `
            position: fixed;
            bottom: 24px;
            left: 50%;
            transform: translateX(-50%);
            background: rgba(15, 17, 26, 0.94);
            color: #7dcfff;
            border: 1px dashed #7dcfff;
            border-radius: 10px;
            padding: 10px 24px;
            font-family: 'Consolas', 'Courier New', monospace;
            font-size: 15px;
            font-weight: bold;
            box-shadow: 0 10px 30px rgba(0,0,0,0.7);
            z-index: 2147483647;
            display: none;
            align-items: center;
            gap: 12px;
            backdrop-filter: blur(8px);
            transition: opacity 0.2s ease;
        `;
        
        const icon = document.createElement('span');
        icon.innerHTML = '⌨';
        icon.style.cssText = 'font-size: 18px; color: #f7768e;';
        
        const textSpan = document.createElement('span');
        textSpan.id = 'py-web-tester-hud-text';
        textSpan.style.cssText = 'color: #a6e3a1; letter-spacing: 0.5px;';

        hud.appendChild(icon);
        hud.appendChild(textSpan);
        (document.body || document.documentElement).appendChild(hud);
    }

    let hudTimeout = null;
    window.__showKeystroke = function(msg) {
        const textSpan = document.getElementById('py-web-tester-hud-text');
        const hudEl = document.getElementById('py-web-tester-keystroke-hud');
        if (textSpan && hudEl) {
            textSpan.textContent = msg;
            hudEl.style.display = 'flex';
            hudEl.style.opacity = '1';
            if (hudTimeout) clearTimeout(hudTimeout);
            hudTimeout = setTimeout(() => {
                hudEl.style.opacity = '0';
                setTimeout(() => { hudEl.style.display = 'none'; }, 200);
            }, 2200);
        }
    };

    window.__moveCursorTo = function(x, y) {
        const cursorEl = document.getElementById('py-web-tester-cursor');
        if (cursorEl) {
            cursorEl.style.left = x + 'px';
            cursorEl.style.top = y + 'px';
            cursorEl.style.display = 'block';
        }
    };

    window.__createClickRipple = function(x, y) {
        const ripple = document.createElement('div');
        ripple.style.cssText = `
            position: fixed;
            left: ${x}px;
            top: ${y}px;
            width: 10px;
            height: 10px;
            border-radius: 50%;
            border: 2px solid #7dcfff;
            background: rgba(125, 207, 255, 0.5);
            pointer-events: none;
            z-index: 2147483646;
            transform: translate(-50%, -50%) scale(1);
            transition: transform 0.4s ease-out, opacity 0.4s ease-out;
        `;
        (document.body || document.documentElement).appendChild(ripple);
        requestAnimationFrame(() => {
            ripple.style.transform = 'translate(-50%, -50%) scale(4.5)';
            ripple.style.opacity = '0';
        });
        setTimeout(() => { ripple.remove(); }, 450);
    };

    document.addEventListener('mousemove', (e) => {
        window.__moveCursorTo(e.clientX, e.clientY);
    }, { passive: true });

    document.addEventListener('click', (e) => {
        window.__moveCursorTo(e.clientX, e.clientY);
        window.__createClickRipple(e.clientX, e.clientY);
    }, { passive: true });

    document.addEventListener('input', (e) => {
        const target = e.target;
        if (target && (target.tagName === 'INPUT' || target.tagName === 'TEXTAREA' || target.isContentEditable)) {
            const val = target.value || target.innerText || '';
            const fieldName = target.placeholder || target.name || target.id || 'Eingabefeld';
            window.__showKeystroke(`[${fieldName}]: "${val}"`);
            
            const rect = target.getBoundingClientRect();
            window.__moveCursorTo(rect.left + rect.width / 2, rect.top + rect.height / 2);
        }
    }, { passive: true });

    document.addEventListener('keydown', (e) => {
        if (e.key === 'Enter' || e.key === 'Tab' || e.key === 'Escape' || e.key.startsWith('Arrow')) {
            window.__showKeystroke(`[Taste gedrückt]: ${e.key}`);
        }
    }, { passive: true });
})();
"""

class visual_hud:
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'

    @keyword("Inject Visual Pointer And Keystroke HUD")
    def inject_visual_hud(self):
        """Injects visual mouse cursor and keystroke HUD into the current browser page."""
        try:
            browser_lib = BuiltIn().get_library_instance("Browser")
            browser_lib.evaluate_javascript(None, VISUAL_HUD_SCRIPT)
        except Exception:
            pass

    @keyword("Animate Visual Pointer To Element")
    def animate_visual_pointer_to_element(self, selector: str):
        """Smoothly animates the glowing mouse pointer cursor to the target element before clicking."""
        try:
            browser_lib = BuiltIn().get_library_instance("Browser")
            js_code = f"""
            (function() {{
                try {{
                    let cursor = document.getElementById('py-web-tester-cursor');
                    if (!cursor) {{
                        eval({json.dumps(VISUAL_HUD_SCRIPT)});
                        cursor = document.getElementById('py-web-tester-cursor');
                    }}
                    let el = null;
                    const cleanSel = {json.dumps(selector)};
                    if (cleanSel.startsWith('css=')) {{
                        el = document.querySelector(cleanSel.substring(4));
                    }} else if (cleanSel.startsWith('#') || cleanSel.startsWith('.') || cleanSel.includes('>')) {{
                        el = document.querySelector(cleanSel);
                    }} else {{
                        try {{ el = document.querySelector(cleanSel); }} catch(e) {{}}
                    }}

                    if (el && cursor) {{
                        const rect = el.getBoundingClientRect();
                        const targetX = Math.round(rect.left + rect.width / 2);
                        const targetY = Math.round(rect.top + rect.height / 2);
                        cursor.style.transition = 'left 0.18s ease-out, top 0.18s ease-out';
                        cursor.style.left = targetX + 'px';
                        cursor.style.top = targetY + 'px';
                        cursor.style.display = 'block';

                        if (window.__createClickRipple) {{
                            window.__createClickRipple(targetX, targetY);
                        }}
                    }}
                }} catch(e) {{}}
            }})();
            """
            browser_lib.evaluate_javascript(None, js_code)
        except Exception:
            pass

    @keyword("Show Keystroke Overlay")
    def show_keystroke_overlay(self, message: str):
        """Displays custom text in the bottom Keystroke HUD bar."""
        try:
            browser_lib = BuiltIn().get_library_instance("Browser")
            js_code = f"window.__showKeystroke && window.__showKeystroke({repr(message)});"
            browser_lib.evaluate_javascript(None, js_code)
        except Exception:
            pass
