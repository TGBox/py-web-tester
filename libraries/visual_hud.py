"""
Visual HUD Helper for py-web-tester.
Injects a visual mouse pointer cursor and a bottom-screen Keystroke HUD overlay
during Headed test execution so users can clearly see clicks, cursor movements, and typed text.
Includes robust selector parser for Playwright :has-text(), XPath, and escaped CSS selectors.
"""

from robot.api.deco import keyword
from robot.libraries.BuiltIn import BuiltIn

class visual_hud:
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'

    def _has_active_page(self, browser_lib) -> bool:
        try:
            page_ids = browser_lib.get_page_ids()
            return bool(page_ids)
        except Exception:
            return False

    @keyword("Inject Visual Pointer And Keystroke HUD")
    def inject_visual_hud(self):
        """Injects visual mouse cursor and keystroke HUD into the current browser page."""
        try:
            browser_lib = BuiltIn().get_library_instance("Browser")
            if not self._has_active_page(browser_lib):
                return

            js_code = """
            (function() {
                function initHud() {
                    const parent = document.body || document.documentElement;
                    if (!parent) return;

                    let cursor = document.getElementById('py-web-tester-cursor');
                    if (!cursor) {
                        cursor = document.createElement('div');
                        cursor.id = 'py-web-tester-cursor';
                        cursor.style.cssText = `
                            position: fixed !important;
                            top: 100px;
                            left: 100px;
                            width: 32px !important;
                            height: 32px !important;
                            border-radius: 50% !important;
                            background: rgba(0, 240, 255, 0.9) !important;
                            border: 3px solid #ffffff !important;
                            box-shadow: 0 0 25px rgba(0, 240, 255, 1), 0 0 10px rgba(0,0,0,0.9) !important;
                            pointer-events: none !important;
                            z-index: 2147483647 !important;
                            transition: left 0.25s ease-out, top 0.25s ease-out, transform 0.15s ease !important;
                            transform: translate(-50%, -50%) !important;
                            display: block !important;
                            opacity: 1 !important;
                        `;
                        const dot = document.createElement('div');
                        dot.style.cssText = 'width:8px; height:8px; background:#ffffff; border-radius:50%; margin:9px auto; box-shadow: 0 0 6px #000;';
                        cursor.appendChild(dot);
                        parent.appendChild(cursor);
                    }

                    let hud = document.getElementById('py-web-tester-keystroke-hud');
                    if (!hud) {
                        hud = document.createElement('div');
                        hud.id = 'py-web-tester-keystroke-hud';
                        hud.style.cssText = `
                            position: fixed !important;
                            bottom: 30px !important;
                            left: 50% !important;
                            transform: translateX(-50%) !important;
                            background: rgba(10, 15, 26, 0.96) !important;
                            color: #00f0ff !important;
                            border: 2px solid #00f0ff !important;
                            border-radius: 12px !important;
                            padding: 14px 32px !important;
                            font-family: 'Consolas', 'Courier New', monospace !important;
                            font-size: 18px !important;
                            font-weight: bold !important;
                            box-shadow: 0 12px 40px rgba(0,0,0,0.9), 0 0 20px rgba(0, 240, 255, 0.6) !important;
                            z-index: 2147483647 !important;
                            display: none !important;
                            align-items: center !important;
                            gap: 16px !important;
                            backdrop-filter: blur(10px) !important;
                            transition: opacity 0.2s ease !important;
                        `;
                        const icon = document.createElement('span');
                        icon.innerHTML = '⌨';
                        icon.style.cssText = 'font-size: 22px; color: #ff007f;';
                        
                        const textSpan = document.createElement('span');
                        textSpan.id = 'py-web-tester-hud-text';
                        textSpan.style.cssText = 'color: #00ffcc; letter-spacing: 0.8px;';

                        hud.appendChild(icon);
                        hud.appendChild(textSpan);
                        parent.appendChild(hud);
                    }
                }
                if (document.readyState === 'loading') {
                    document.addEventListener('DOMContentLoaded', initHud);
                } else {
                    initHud();
                }
            })();
            """
            browser_lib.evaluate_javascript(None, js_code)
        except Exception:
            pass

    @keyword("Show Keystroke Overlay")
    def show_keystroke_overlay(self, message: str):
        """Displays custom text in the bottom Keystroke HUD bar during playback."""
        try:
            browser_lib = BuiltIn().get_library_instance("Browser")
            if not self._has_active_page(browser_lib):
                return

            import json
            js_code = f"""
            (function() {{
                try {{
                    const msg = {json.dumps(message)};
                    if (!msg) return;

                    let hud = document.getElementById('py-web-tester-keystroke-hud');
                    if (!hud) {{
                        hud = document.createElement('div');
                        hud.id = 'py-web-tester-keystroke-hud';
                        hud.style.cssText = `
                            position: fixed !important;
                            bottom: 30px !important;
                            left: 50% !important;
                            transform: translateX(-50%) !important;
                            background: rgba(10, 15, 26, 0.96) !important;
                            color: #00f0ff !important;
                            border: 2px solid #00f0ff !important;
                            border-radius: 12px !important;
                            padding: 14px 32px !important;
                            font-family: 'Consolas', 'Courier New', monospace !important;
                            font-size: 18px !important;
                            font-weight: bold !important;
                            box-shadow: 0 12px 40px rgba(0,0,0,0.9), 0 0 20px rgba(0, 240, 255, 0.6) !important;
                            z-index: 2147483647 !important;
                            display: flex !important;
                            align-items: center !important;
                            gap: 16px !important;
                            backdrop-filter: blur(10px) !important;
                            transition: opacity 0.2s ease !important;
                        `;
                        const icon = document.createElement('span');
                        icon.innerHTML = '⌨';
                        icon.style.cssText = 'font-size: 22px; color: #ff007f;';
                        
                        const textSpan = document.createElement('span');
                        textSpan.id = 'py-web-tester-hud-text';
                        textSpan.style.cssText = 'color: #00ffcc; letter-spacing: 0.8px;';

                        hud.appendChild(icon);
                        hud.appendChild(textSpan);
                        (document.body || document.documentElement).appendChild(hud);
                    }}

                    const textSpan = document.getElementById('py-web-tester-hud-text');
                    if (textSpan) {{
                        textSpan.textContent = msg;
                    }}
                    hud.style.setProperty('display', 'flex', 'important');
                    hud.style.setProperty('opacity', '1', 'important');

                    if (window.__pyHudTimeout) clearTimeout(window.__pyHudTimeout);
                    window.__pyHudTimeout = setTimeout(() => {{
                        if (hud) hud.style.setProperty('opacity', '0', 'important');
                        setTimeout(() => {{
                            if (hud) hud.style.setProperty('display', 'none', 'important');
                        }}, 250);
                    }}, 2800);
                }} catch(e) {{}}
            }})();
            """
            browser_lib.evaluate_javascript(None, js_code)
        except Exception:
            pass

    @keyword("Animate Visual Pointer To Element")
    def animate_visual_pointer(self, selector: str):
        """Glides the visual mouse pointer to the center of the given element selector and highlights it."""
        try:
            browser_lib = BuiltIn().get_library_instance("Browser")
            if not self._has_active_page(browser_lib):
                return

            import json
            js_code = f"""
            (function() {{
                try {{
                    const sel = {json.dumps(selector)};

                    function ensureCursor() {{
                        let cursor = document.getElementById('py-web-tester-cursor');
                        if (!cursor) {{
                            cursor = document.createElement('div');
                            cursor.id = 'py-web-tester-cursor';
                            cursor.style.cssText = `
                                position: fixed !important;
                                top: 100px;
                                left: 100px;
                                width: 32px !important;
                                height: 32px !important;
                                border-radius: 50% !important;
                                background: rgba(0, 240, 255, 0.9) !important;
                                border: 3px solid #ffffff !important;
                                box-shadow: 0 0 25px rgba(0, 240, 255, 1), 0 0 10px rgba(0,0,0,0.9) !important;
                                pointer-events: none !important;
                                z-index: 2147483647 !important;
                                transition: left 0.25s ease-out, top 0.25s ease-out, transform 0.15s ease !important;
                                transform: translate(-50%, -50%) !important;
                                display: block !important;
                                opacity: 1 !important;
                            `;
                            const dot = document.createElement('div');
                            dot.style.cssText = 'width:8px; height:8px; background:#ffffff; border-radius:50%; margin:9px auto; box-shadow: 0 0 6px #000;';
                            cursor.appendChild(dot);
                            (document.body || document.documentElement).appendChild(cursor);
                        }}
                        return cursor;
                    }}

                    function findElement(s) {{
                        if (!s) return document.activeElement;
                        let clean = s.trim();
                        if (clean.startsWith('css=')) clean = clean.substring(4);
                        if (clean.startsWith('xpath=')) {{
                            try {{
                                const res = document.evaluate(clean.substring(6), document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
                                if (res) return res;
                            }} catch(e) {{}}
                        }}

                        if (clean.includes(':has-text(')) {{
                            const idx = clean.indexOf(':has-text(');
                            const tagPart = clean.substring(0, idx).trim() || '*';
                            const rest = clean.substring(idx + 10);
                            let targetTxt = rest.replace(/^["']/, '').replace(/["']\\)$/, '').replace(/\\)$/, '');
                            try {{
                                const candidates = document.querySelectorAll(tagPart);
                                for (let cand of candidates) {{
                                    if ((cand.innerText || cand.textContent || '').includes(targetTxt)) {{
                                        return cand;
                                    }}
                                }}
                            }} catch(e) {{}}
                        }}

                        // Direct querySelector
                        try {{
                            const direct = document.querySelector(clean);
                            if (direct) return direct;
                        }} catch(e) {{}}

                        // Try extracting ID from selector (e.g. mat-form-field#email)
                        const idMatch = clean.match(/#([a-zA-Z0-9_-]+)/);
                        if (idMatch && idMatch[1]) {{
                            const elById = document.getElementById(idMatch[1]);
                            if (elById) return elById;
                        }}

                        // Try sub-selector matching
                        try {{
                            const parts = clean.split('>');
                            const lastPart = parts[parts.length - 1].trim();
                            if (lastPart) {{
                                const subMatch = document.querySelector(lastPart);
                                if (subMatch) return subMatch;
                            }}
                        }} catch(e) {{}}

                        // Fallback to activeElement if focused
                        if (document.activeElement && document.activeElement !== document.body) {{
                            return document.activeElement;
                        }}
                        return null;
                    }}

                    const el = findElement(sel) || document.activeElement;
                    const cursor = ensureCursor();
                    if (el && el !== document.body) {{
                        let rect = el.getBoundingClientRect();
                        if (rect.width === 0 && rect.height === 0 && el.parentElement) {{
                            rect = el.parentElement.getBoundingClientRect();
                        }}
                        const x = Math.round(rect.left + rect.width / 2);
                        const y = Math.round(rect.top + rect.height / 2);
                        if (x > 0 || y > 0) {{
                            cursor.style.setProperty('left', x + 'px', 'important');
                            cursor.style.setProperty('top', y + 'px', 'important');
                            cursor.style.setProperty('display', 'block', 'important');
                            cursor.style.setProperty('opacity', '1', 'important');

                            const origOutline = el.style.outline;
                            el.style.outline = '3px solid #00f0ff';
                            el.style.outlineOffset = '2px';
                            setTimeout(() => {{ el.style.outline = origOutline; }}, 450);

                            const ripple = document.createElement('div');
                            ripple.style.cssText = `
                                position: fixed !important;
                                left: ${{x}}px !important;
                                top: ${{y}}px !important;
                                width: 12px !important;
                                height: 12px !important;
                                border-radius: 50% !important;
                                border: 3px solid #00f0ff !important;
                                background: rgba(0, 240, 255, 0.6) !important;
                                pointer-events: none !important;
                                z-index: 2147483646 !important;
                                transform: translate(-50%, -50%) scale(1) !important;
                                transition: transform 0.45s ease-out, opacity 0.45s ease-out !important;
                            `;
                            (document.body || document.documentElement).appendChild(ripple);
                            requestAnimationFrame(() => {{
                                ripple.style.transform = 'translate(-50%, -50%) scale(4.5)';
                                ripple.style.opacity = '0';
                            }});
                            setTimeout(() => {{ ripple.remove(); }}, 500);
                        }}
                    }}
                }} catch(ex) {{}}
            }})();
            """
            browser_lib.evaluate_javascript(None, js_code)
        except Exception:
            pass
