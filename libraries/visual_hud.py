"""
Visual HUD Helper for py-web-tester.
Injects a classic SVG arrow mouse pointer cursor and a Top Infobox Overlay at the top center of the screen
during Headed test execution so users can clearly see cursor movements, clicks, keystrokes, and active step descriptions.
Features a hybrid locator: Playwright get_bounding_box() server-side exact resolution + browser JS selector parser fallback.
Resolves Robot Framework variable strings (e.g. ${SELECTOR_...}) automatically.
"""

import json
from robot.api.deco import keyword
from robot.libraries.BuiltIn import BuiltIn

CURSOR_SVG = '<svg width="28" height="28" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M3 3L10.07 20.97L13.58 13.58L20.97 10.07L3 3Z" fill="#ffffff" stroke="#0f172a" stroke-width="2" stroke-linejoin="round"/><path d="M13.58 13.58L19 19" stroke="#0f172a" stroke-width="2.5" stroke-linecap="round"/></svg>'

class visual_hud:
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'

    def _has_active_page(self, browser_lib) -> bool:
        try:
            page_ids = browser_lib.get_page_ids()
            return bool(page_ids)
        except Exception:
            return False

    def _resolve_variable(self, val: str) -> str:
        if not isinstance(val, str):
            return str(val) if val is not None else ""
        val_clean = val.strip()
        if val_clean.startswith("${") and val_clean.endswith("}"):
            try:
                resolved = BuiltIn().get_variable_value(val_clean)
                if resolved is not None:
                    return str(resolved)
            except Exception:
                pass
        return val

    def _get_ensure_hud_js_body(self) -> str:
        return f"""
        let parent = document.body || document.documentElement;
        if (!parent) return;

        let cursor = document.getElementById('py-web-tester-cursor');
        if (!cursor) {{
            cursor = document.createElement('div');
            cursor.id = 'py-web-tester-cursor';
            cursor.style.cssText = 'position: fixed !important; top: 100px; left: 100px; width: 28px !important; height: 28px !important; pointer-events: none !important; z-index: 2147483647 !important; transition: left 0.22s ease-out, top 0.22s ease-out, transform 0.15s ease !important; transform: translate(0, 0) !important; display: block !important; opacity: 1 !important; filter: drop-shadow(0 4px 8px rgba(0,0,0,0.65)) !important;';
            cursor.innerHTML = '{CURSOR_SVG}';
            parent.appendChild(cursor);
        }}

        let hud = document.getElementById('py-web-tester-keystroke-hud');
        if (!hud) {{
            hud = document.createElement('div');
            hud.id = 'py-web-tester-keystroke-hud';
            hud.style.cssText = 'position: fixed !important; top: 15px !important; left: 50% !important; transform: translateX(-50%) !important; background: rgba(15, 23, 42, 0.95) !important; color: #38bdf8 !important; border: 2px solid #38bdf8 !important; border-radius: 10px !important; padding: 10px 26px !important; font-family: Consolas, Segoe UI, monospace !important; font-size: 15px !important; font-weight: 600 !important; box-shadow: 0 8px 30px rgba(0,0,0,0.7), 0 0 15px rgba(56, 189, 248, 0.4) !important; pointer-events: none !important; z-index: 2147483647 !important; display: none !important; align-items: center !important; gap: 12px !important; backdrop-filter: blur(8px) !important; transition: all 0.25s ease-out !important;';
            
            const icon = document.createElement('span');
            icon.innerHTML = '\\u2328';
            icon.style.cssText = 'font-size: 18px; color: #f43f5e;';
            
            const textSpan = document.createElement('span');
            textSpan.id = 'py-web-tester-hud-text';
            textSpan.style.cssText = 'color: #38bdf8; letter-spacing: 0.6px;';

            hud.appendChild(icon);
            hud.appendChild(textSpan);
            parent.appendChild(hud);
        }}
        """

    @keyword("Inject Visual Pointer And Keystroke HUD")
    def inject_visual_hud(self):
        """Injects classic SVG mouse pointer and Top Infobox overlay into current browser page."""
        try:
            browser_lib = BuiltIn().get_library_instance("Browser")
            if not self._has_active_page(browser_lib):
                return

            js_code = f"(function() {{ {self._get_ensure_hud_js_body()} }})();"
            browser_lib.evaluate_javascript(None, js_code)
        except Exception:
            pass

    @keyword("Show Keystroke Overlay")
    def show_keystroke_overlay(self, message: str):
        """Displays step description or typed text in the Top Infobox Overlay."""
        try:
            browser_lib = BuiltIn().get_library_instance("Browser")
            if not self._has_active_page(browser_lib):
                return

            message = self._resolve_variable(message)
            if not message:
                return

            self.inject_visual_hud()

            msg_json = json.dumps(message)
            js_code = f"""
            (function() {{
                const hud = document.getElementById('py-web-tester-keystroke-hud');
                const textSpan = document.getElementById('py-web-tester-hud-text');
                if (textSpan) textSpan.textContent = {msg_json};
                if (hud) {{
                    hud.style.setProperty('display', 'flex', 'important');
                    hud.style.setProperty('opacity', '1', 'important');
                    hud.style.setProperty('transform', 'translateX(-50%) translateY(0)', 'important');

                    if (window.__pyHudTimeout) clearTimeout(window.__pyHudTimeout);
                    window.__pyHudTimeout = setTimeout(() => {{
                        if (hud) {{
                            hud.style.setProperty('opacity', '0', 'important');
                            hud.style.setProperty('transform', 'translateX(-50%) translateY(-10px)', 'important');
                        }}
                        setTimeout(() => {{
                            if (hud) hud.style.setProperty('display', 'none', 'important');
                        }}, 250);
                    }}, 2800);
                }}
            }})();
            """
            browser_lib.evaluate_javascript(None, js_code)
        except Exception:
            pass

    def _move_cursor_to_coords(self, browser_lib, x: int, y: int):
        """Moves cursor to explicit (x, y) coordinates and triggers a click pulse animation."""
        try:
            self.inject_visual_hud()

            js_code = f"""
            (function() {{
                const cursor = document.getElementById('py-web-tester-cursor');
                if (cursor) {{
                    cursor.style.setProperty('left', '{x}px', 'important');
                    cursor.style.setProperty('top', '{y}px', 'important');
                    cursor.style.setProperty('display', 'block', 'important');
                    cursor.style.setProperty('opacity', '1', 'important');

                    cursor.style.setProperty('transform', 'scale(0.85)', 'important');
                    setTimeout(() => {{
                        if (cursor) cursor.style.setProperty('transform', 'scale(1)', 'important');
                    }}, 150);
                }}

                const ripple = document.createElement('div');
                ripple.style.cssText = 'position: fixed !important; left: {x}px !important; top: {y}px !important; width: 14px !important; height: 14px !important; border-radius: 50% !important; border: 2.5px solid #38bdf8 !important; background: rgba(56, 189, 248, 0.4) !important; pointer-events: none !important; z-index: 2147483646 !important; transform: translate(-50%, -50%) scale(1) !important; transition: transform 0.45s ease-out, opacity 0.45s ease-out !important;';
                const parent = document.body || document.documentElement;
                if (parent) parent.appendChild(ripple);
                requestAnimationFrame(() => {{
                    ripple.style.transform = 'translate(-50%, -50%) scale(4)';
                    ripple.style.opacity = '0';
                }});
                setTimeout(() => {{ ripple.remove(); }}, 500);
            }})();
            """
            browser_lib.evaluate_javascript(None, js_code)
        except Exception:
            pass

    @keyword("Animate Visual Pointer To Element")
    def animate_visual_pointer(self, selector: str):
        """Glides the visual mouse pointer to the center of the given element selector using getBoundingClientRect() dynamic bounds."""
        try:
            browser_lib = BuiltIn().get_library_instance("Browser")
            if not self._has_active_page(browser_lib):
                return

            selector = self._resolve_variable(selector)
            if not selector or selector == "None" or selector == "about:blank":
                return

            # Step 1: Playwright selector resolution + getBoundingClientRect via element handle
            x, y = None, None
            js_rect_code = """(element) => {
                if (!element) return null;
                const rect = element.getBoundingClientRect();
                if (rect.width > 0 || rect.height > 0) {
                    const targetX = Math.round(rect.left + rect.width / 2);
                    const targetY = Math.round(rect.top + rect.height / 2);
                    return { x: targetX, y: targetY };
                }
                return null;
            }"""
            try:
                res = browser_lib.evaluate_javascript(selector, js_rect_code)
                if res and isinstance(res, dict):
                    x = res.get("x")
                    y = res.get("y")
            except Exception:
                pass

            # Step 2: Fallback to document JS parser if selector is custom or complex
            if x is None or y is None:
                js_code = f"""
                (function() {{
                    try {{
                        const sel = {json.dumps(selector)};

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

                            try {{
                                const direct = document.querySelector(clean);
                                if (direct) return direct;
                            }} catch(e) {{}}

                            const idMatch = clean.match(/#([a-zA-Z0-9_-]+)/);
                            if (idMatch && idMatch[1]) {{
                                const elById = document.getElementById(idMatch[1]);
                                if (elById) return elById;
                            }}

                            if (document.activeElement && document.activeElement !== document.body) {{
                                return document.activeElement;
                            }}
                            return null;
                        }}

                        const el = findElement(sel);
                        if (el && el !== document.body) {{
                            const rect = el.getBoundingClientRect();
                            if (rect.width > 0 || rect.height > 0) {{
                                const targetX = Math.round(rect.left + rect.width / 2);
                                const targetY = Math.round(rect.top + rect.height / 2);
                                return {{ x: targetX, y: targetY }};
                            }}
                        }}
                        return null;
                    }} catch(ex) {{ return null; }}
                }})();
                """
                res = browser_lib.evaluate_javascript(None, js_code)
                if res and isinstance(res, dict):
                    x = res.get("x")
                    y = res.get("y")

            if x is not None and y is not None and (x > 0 or y > 0):
                self._move_cursor_to_coords(browser_lib, x, y)
        except Exception:
            pass

