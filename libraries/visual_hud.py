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

    @keyword("Inject Visual Pointer And Keystroke HUD")
    def inject_visual_hud(self):
        """Injects visual mouse cursor and keystroke HUD into the current browser page."""
        pass

    @keyword("Show Keystroke Overlay")
    def show_keystroke_overlay(self, message: str):
        """Displays custom text in the bottom Keystroke HUD bar during playback."""
        try:
            import json
            browser_lib = BuiltIn().get_library_instance("Browser")
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
                            bottom: 28px !important;
                            left: 50% !important;
                            transform: translateX(-50%) !important;
                            background: rgba(15, 20, 32, 0.96) !important;
                            color: #7dcfff !important;
                            border: 2px solid #7dcfff !important;
                            border-radius: 12px !important;
                            padding: 12px 28px !important;
                            font-family: 'Consolas', 'Courier New', monospace !important;
                            font-size: 16px !important;
                            font-weight: bold !important;
                            box-shadow: 0 10px 35px rgba(0,0,0,0.85), 0 0 18px rgba(125, 207, 255, 0.5) !important;
                            z-index: 2147483647 !important;
                            display: flex !important;
                            align-items: center !important;
                            gap: 14px !important;
                            backdrop-filter: blur(10px) !important;
                            transition: opacity 0.2s ease !important;
                        `;
                        const icon = document.createElement('span');
                        icon.innerHTML = '⌨';
                        icon.style.cssText = 'font-size: 20px; color: #f7768e;';
                        
                        const textSpan = document.createElement('span');
                        textSpan.id = 'py-web-tester-hud-text';
                        textSpan.style.cssText = 'color: #a6e3a1; letter-spacing: 0.5px;';

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
                    }}, 2200);
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
            import json
            browser_lib = BuiltIn().get_library_instance("Browser")

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
                                top: -100px;
                                left: -100px;
                                width: 28px !important;
                                height: 28px !important;
                                border-radius: 50% !important;
                                background: rgba(0, 229, 255, 0.85) !important;
                                border: 3px solid #ffffff !important;
                                box-shadow: 0 0 20px rgba(0, 229, 255, 1), 0 0 8px rgba(0,0,0,0.9) !important;
                                pointer-events: none !important;
                                z-index: 2147483647 !important;
                                transition: left 0.22s ease-out, top 0.22s ease-out, transform 0.12s ease !important;
                                transform: translate(-50%, -50%) !important;
                                display: block !important;
                                opacity: 1 !important;
                            `;
                            const dot = document.createElement('div');
                            dot.style.cssText = 'width:7px; height:7px; background:#ffffff; border-radius:50%; margin:8px auto; box-shadow: 0 0 4px #000;';
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

                        try {{
                            const direct = document.querySelector(clean);
                            if (direct) return direct;
                        }} catch(e) {{}}

                        try {{
                            const parts = clean.split('>');
                            const lastPart = parts[parts.length - 1].trim();
                            if (lastPart) {{
                                const subMatch = document.querySelector(lastPart);
                                if (subMatch) return subMatch;
                            }}
                        }} catch(e) {{}}

                        if (document.activeElement && document.activeElement !== document.body) {{
                            return document.activeElement;
                        }}
                        return null;
                    }}

                    const el = findElement(sel);
                    if (el) {{
                        const cursor = ensureCursor();
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
                            el.style.outline = '2px solid #00e5ff';
                            el.style.outlineOffset = '2px';
                            setTimeout(() => {{ el.style.outline = origOutline; }}, 400);

                            const ripple = document.createElement('div');
                            ripple.style.cssText = `
                                position: fixed !important;
                                left: ${{x}}px !important;
                                top: ${{y}}px !important;
                                width: 10px !important;
                                height: 10px !important;
                                border-radius: 50% !important;
                                border: 2px solid #00e5ff !important;
                                background: rgba(0, 229, 255, 0.5) !important;
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
                            setTimeout(() => {{ ripple.remove(); }}, 450);
                        }}
                    }}
                }} catch(ex) {{}}
            }})();
            """
            browser_lib.evaluate_javascript(None, js_code)
        except Exception:
            pass
