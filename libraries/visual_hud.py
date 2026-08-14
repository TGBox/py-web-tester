"""
Visual HUD Helper for py-web-tester.
Injects a visual mouse pointer cursor and a bottom-screen Keystroke HUD overlay
during Headed test execution so users can clearly see clicks, cursor movements, and typed text.
"""

from robot.api.deco import keyword
from robot.libraries.BuiltIn import BuiltIn

VISUAL_HUD_SCRIPT = """
(function() {
    if (window.__PY_VISUAL_HUD_INJECTED__) return;
    window.__PY_VISUAL_HUD_INJECTED__ = true;

    // 1. Create Visual Mouse Pointer Overlay
    const cursor = document.createElement('div');
    cursor.id = 'py-web-tester-cursor';
    cursor.style.cssText = `
        position: fixed;
        top: -50px;
        left: -50px;
        width: 22px;
        height: 22px;
        border-radius: 50%;
        background: rgba(255, 0, 110, 0.75);
        border: 2px solid #ffffff;
        box-shadow: 0 0 12px rgba(255, 0, 110, 0.9), 0 0 4px #000;
        pointer-events: none;
        z-index: 2147483647;
        transition: transform 0.08s ease, left 0.12s ease-out, top 0.12s ease-out;
        transform: translate(-50%, -50%);
        display: block;
    `;
    const dot = document.createElement('div');
    dot.style.cssText = 'width:6px; height:6px; background:#fff; border-radius:50%; margin:6px auto;';
    cursor.appendChild(dot);
    document.documentElement.appendChild(cursor);

    // 2. Create Bottom Keystroke HUD Overlay
    const hud = document.createElement('div');
    hud.id = 'py-web-tester-keystroke-hud';
    hud.style.cssText = `
        position: fixed;
        bottom: 24px;
        left: 50%;
        transform: translateX(-50%);
        background: rgba(15, 17, 26, 0.92);
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
    document.documentElement.appendChild(hud);

    let hudTimeout = null;
    window.__showKeystroke = function(msg) {
        textSpan.textContent = msg;
        hud.style.display = 'flex';
        hud.style.opacity = '1';
        if (hudTimeout) clearTimeout(hudTimeout);
        hudTimeout = setTimeout(() => {
            hud.style.opacity = '0';
            setTimeout(() => { hud.style.display = 'none'; }, 200);
        }, 2200);
    };

    window.__moveCursorTo = function(x, y) {
        cursor.style.left = x + 'px';
        cursor.style.top = y + 'px';
    };

    function createClickRipple(x, y) {
        const ripple = document.createElement('div');
        ripple.style.cssText = `
            position: fixed;
            left: ${x}px;
            top: ${y}px;
            width: 10px;
            height: 10px;
            border-radius: 50%;
            border: 2px solid #7dcfff;
            background: rgba(125, 207, 255, 0.4);
            pointer-events: none;
            z-index: 2147483646;
            transform: translate(-50%, -50%) scale(1);
            transition: transform 0.4s ease-out, opacity 0.4s ease-out;
        `;
        document.documentElement.appendChild(ripple);
        requestAnimationFrame(() => {
            ripple.style.transform = 'translate(-50%, -50%) scale(4.5)';
            ripple.style.opacity = '0';
        });
        setTimeout(() => { ripple.remove(); }, 450);
    }

    document.addEventListener('mousemove', (e) => {
        window.__moveCursorTo(e.clientX, e.clientY);
    }, { passive: true });

    document.addEventListener('click', (e) => {
        window.__moveCursorTo(e.clientX, e.clientY);
        createClickRipple(e.clientX, e.clientY);
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
