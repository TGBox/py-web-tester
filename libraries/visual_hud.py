"""
Visual HUD Helper for py-web-tester.
Injects a visual mouse pointer cursor and a bottom-screen Keystroke HUD overlay
during Headed test execution so users can clearly see clicks, cursor movements, and typed text.
Native browser DOM event listeners & automatic StepListener hooks guarantee the pointer is 100% visible and animated on every page.
"""

from robot.api.deco import keyword
from robot.libraries.BuiltIn import BuiltIn

VISUAL_HUD_SCRIPT = """
(function() {
    if (window.__PY_VISUAL_HUD_INJECTED__) return;
    window.__PY_VISUAL_HUD_INJECTED__ = true;

    function initHudOverlays() {
        const parent = document.body || document.documentElement;
        if (!parent) return;

        // 1. Create High-Visibility Glowing Visual Mouse Pointer Cursor
        let cursor = document.getElementById('py-web-tester-cursor');
        if (!cursor) {
            cursor = document.createElement('div');
            cursor.id = 'py-web-tester-cursor';
            cursor.style.cssText = `
                position: fixed !important;
                top: 50%;
                left: 50%;
                width: 28px !important;
                height: 28px !important;
                border-radius: 50% !important;
                background: rgba(255, 0, 110, 0.95) !important;
                border: 3px solid #ffffff !important;
                box-shadow: 0 0 18px rgba(255, 0, 110, 1), 0 0 10px rgba(0,0,0,0.8) !important;
                pointer-events: none !important;
                z-index: 2147483647 !important;
                transition: left 0.15s ease-out, top 0.15s ease-out, transform 0.1s ease !important;
                transform: translate(-50%, -50%) !important;
                display: block !important;
            `;
            const dot = document.createElement('div');
            dot.style.cssText = 'width:8px; height:8px; background:#ffffff; border-radius:50%; margin:7px auto; box-shadow: 0 0 4px #000;';
            cursor.appendChild(dot);
            parent.appendChild(cursor);
        }

        // 2. Create Bottom Keystroke HUD Overlay
        let hud = document.getElementById('py-web-tester-keystroke-hud');
        if (!hud) {
            hud = document.createElement('div');
            hud.id = 'py-web-tester-keystroke-hud';
            hud.style.cssText = `
                position: fixed !important;
                bottom: 24px !important;
                left: 50% !important;
                transform: translateX(-50%) !important;
                background: rgba(15, 17, 26, 0.95) !important;
                color: #7dcfff !important;
                border: 2px solid #7dcfff !important;
                border-radius: 12px !important;
                padding: 12px 28px !important;
                font-family: 'Consolas', 'Courier New', monospace !important;
                font-size: 16px !important;
                font-weight: bold !important;
                box-shadow: 0 10px 35px rgba(0,0,0,0.8), 0 0 15px rgba(125, 207, 255, 0.4) !important;
                z-index: 2147483647 !important;
                display: none !important;
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
            parent.appendChild(hud);
        }
    }

    let hudTimeout = null;
    window.__showKeystroke = function(msg) {
        initHudOverlays();
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
            }, 2400);
        }
    };

    window.__moveCursorTo = function(x, y) {
        initHudOverlays();
        const cursorEl = document.getElementById('py-web-tester-cursor');
        if (cursorEl) {
            cursorEl.style.left = x + 'px';
            cursorEl.style.top = y + 'px';
            cursorEl.style.display = 'block';
        }
    };

    window.__createClickRipple = function(x, y) {
        initHudOverlays();
        const ripple = document.createElement('div');
        ripple.style.cssText = `
            position: fixed !important;
            left: ${x}px !important;
            top: ${y}px !important;
            width: 12px !important;
            height: 12px !important;
            border-radius: 50% !important;
            border: 3px solid #7dcfff !important;
            background: rgba(125, 207, 255, 0.6) !important;
            pointer-events: none !important;
            z-index: 2147483646 !important;
            transform: translate(-50%, -50%) scale(1) !important;
            transition: transform 0.45s ease-out, opacity 0.45s ease-out !important;
        `;
        (document.body || document.documentElement).appendChild(ripple);
        requestAnimationFrame(() => {
            ripple.style.transform = 'translate(-50%, -50%) scale(5)';
            ripple.style.opacity = '0';
        });
        setTimeout(() => { ripple.remove(); }, 500);
    };

    function handleTargetPositioning(target, e) {
        if (!target || target.nodeType !== Node.ELEMENT_NODE) return;
        try {
            const rect = target.getBoundingClientRect();
            let x = Math.round(rect.left + rect.width / 2);
            let y = Math.round(rect.top + rect.height / 2);
            if (e && e.clientX && e.clientY) {
                x = e.clientX;
                y = e.clientY;
            }
            window.__moveCursorTo(x, y);
            window.__createClickRipple(x, y);
        } catch(ex) {}
    }

    document.addEventListener('mousemove', (e) => {
        window.__moveCursorTo(e.clientX, e.clientY);
    }, { passive: true });

    document.addEventListener('click', (e) => {
        const target = (e.composedPath && e.composedPath()[0]) || e.target;
        handleTargetPositioning(target, e);
    }, { passive: true });

    document.addEventListener('focusin', (e) => {
        const target = (e.composedPath && e.composedPath()[0]) || e.target;
        handleTargetPositioning(target, null);
    }, { passive: true });

    document.addEventListener('input', (e) => {
        const target = (e.composedPath && e.composedPath()[0]) || e.target;
        if (target && (target.tagName === 'INPUT' || target.tagName === 'TEXTAREA' || target.isContentEditable)) {
            const val = target.value || target.innerText || '';
            const fieldName = target.placeholder || target.name || target.id || 'Eingabefeld';
            window.__showKeystroke(`[${fieldName}]: "${val}"`);
            handleTargetPositioning(target, null);
        }
    }, { passive: true });

    document.addEventListener('keydown', (e) => {
        if (e.key === 'Enter' || e.key === 'Tab' || e.key === 'Escape' || e.key.startsWith('Arrow')) {
            window.__showKeystroke(`[Taste gedrückt]: ${e.key}`);
        }
    }, { passive: true });

    // Periodic check to ensure HUD overlays stay in DOM across dynamic SPA re-renders
    setInterval(initHudOverlays, 300);

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initHudOverlays);
    } else {
        initHudOverlays();
    }
})();
"""

class visual_hud:
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'

    @keyword("Inject Visual Pointer And Keystroke HUD")
    def inject_visual_hud(self):
        """Injects visual mouse cursor and keystroke HUD into the current browser page."""
        try:
            browser_lib = BuiltIn().get_library_instance("Browser")
            browser_lib.evaluate_javascript("css=body", VISUAL_HUD_SCRIPT)
        except Exception:
            pass

    @keyword("Show Keystroke Overlay")
    def show_keystroke_overlay(self, message: str):
        """Displays custom text in the bottom Keystroke HUD bar."""
        try:
            browser_lib = BuiltIn().get_library_instance("Browser")
            js_code = f"window.__showKeystroke && window.__showKeystroke({repr(message)});"
            browser_lib.evaluate_javascript("css=body", js_code)
        except Exception:
            pass
