
        (function() {
            if (window.__PY_WEB_TESTER_RECORDING_INITIALIZED__) return;
            window.__PY_WEB_TESTER_RECORDING_INITIALIZED__ = true;

            let eventCount = 0;
            try {
                const storedCount = sessionStorage.getItem('__PY_RECORDER_ACTION_COUNT__');
                if (storedCount) eventCount = parseInt(storedCount, 10) || 0;
            } catch(e) {}

            let recordingStartTime = Date.now();
            try {
                const storedStart = sessionStorage.getItem('__PY_RECORDER_START_TIME__');
                if (storedStart) {
                    recordingStartTime = parseInt(storedStart, 10) || Date.now();
                } else {
                    sessionStorage.setItem('__PY_RECORDER_START_TIME__', String(recordingStartTime));
                }
            } catch(e) {}

            let lastPendingInputPayload = null;

            function updateHudCount() {
                eventCount++;
                try {
                    sessionStorage.setItem('__PY_RECORDER_ACTION_COUNT__', String(eventCount));
                } catch(e) {}
                const counterEl = document.getElementById('py-hud-counter');
                if (counterEl) {
                    counterEl.textContent = `${eventCount} Action${eventCount === 1 ? '' : 's'}`;
                }
            }

            function emitEvent(payload) {
                try {
                    updateHudCount();
                    console.debug("__PY_WEB_TESTER_EVENT__" + JSON.stringify(payload));
                } catch(e) {
                    console.error("Error emitting event:", e);
                }
            }

            // Flush any pending click/input event stored in sessionStorage before page navigation
            try {
                const pendingStr = sessionStorage.getItem('__PY_RECORDER_PENDING_EVENT__');
                if (pendingStr) {
                    sessionStorage.removeItem('__PY_RECORDER_PENDING_EVENT__');
                    const pendingPayload = JSON.parse(pendingStr);
                    emitEvent(pendingPayload);
                }
            } catch(e) {}

            function emitStop() {
                try {
                    console.debug("__PY_WEB_TESTER_STOP__");
                } catch(e) {}
            }

            function getSafeId(el) {
                if (!el || !el.getAttribute) return '';
                try {
                    const id = el.getAttribute('id');
                    return (typeof id === 'string') ? id.trim() : '';
                } catch(e) { return ''; }
            }

            function getSafeClass(el) {
                if (!el || !el.getAttribute) return '';
                try {
                    const cls = el.getAttribute('class');
                    return (typeof cls === 'string') ? cls.trim() : '';
                } catch(e) { return ''; }
            }

            function getCssSelector(el) {
                if (!el || el.nodeType !== Node.ELEMENT_NODE) return '';
                try {
                    const id = getSafeId(el);
                    if (id && !id.match(/^\d/) && !id.includes(':')) {
                        return `#${CSS.escape(id)}`;
                    }

                    const testId = el.getAttribute ? (el.getAttribute('data-testid') || el.getAttribute('data-test') || el.getAttribute('data-cy')) : null;
                    if (testId) return `[data-testid="${testId}"]`;

                    const name = el.getAttribute ? el.getAttribute('name') : null;
                    if (name) return `${el.tagName.toLowerCase()}[name="${name}"]`;

                    const placeholder = el.getAttribute ? el.getAttribute('placeholder') : null;
                    if (placeholder) return `${el.tagName.toLowerCase()}[placeholder="${placeholder}"]`;

                    const ariaLabel = el.getAttribute ? el.getAttribute('aria-label') : null;
                    if (ariaLabel) return `${el.tagName.toLowerCase()}[aria-label="${ariaLabel}"]`;

                    const role = el.getAttribute ? el.getAttribute('role') : null;
                    if (role) return `${el.tagName.toLowerCase()}[role="${role}"]`;

                    const type = el.getAttribute ? el.getAttribute('type') : null;
                    if (type && el.tagName === 'INPUT') return `input[type="${type}"]`;

                    const text = (el.innerText || el.textContent || '').replace(/[\r\n\t]+/g, ' ').trim();
                    if (text && text.length > 0 && text.length < 35 && ['BUTTON', 'A', 'SPAN', 'LABEL', 'H1', 'H2', 'H3', 'LI'].includes(el.tagName)) {
                        return `${el.tagName.toLowerCase()}:has-text("${text.replace(/"/g, '\"')}")`;
                    }

                    const cls = getSafeClass(el);
                    if (cls) {
                        const validClasses = cls.split(/\s+/)
                            .filter(c => c && !c.includes(':') && !c.match(/^\d/))
                            .slice(0, 2);
                        if (validClasses.length > 0) {
                            const classSelector = `${el.tagName.toLowerCase()}.${validClasses.map(c => CSS.escape(c)).join('.')}`;
                            try {
                                if (document.querySelectorAll(classSelector).length === 1) {
                                    return classSelector;
                                }
                            } catch(e) {}
                        }
                    }

                    let path = [];
                    let current = el;
                    while (current && current.nodeType === Node.ELEMENT_NODE && current.tagName !== 'BODY') {
                        let selector = current.tagName.toLowerCase();
                        const currId = getSafeId(current);
                        if (currId && !currId.match(/^\d/)) {
                            selector += `#${CSS.escape(currId)}`;
                            path.unshift(selector);
                            break;
                        } else {
                            let sibling = current;
                            let nth = 1;
                            while (sibling = sibling.previousElementSibling) {
                                if (sibling.tagName === current.tagName) nth++;
                            }
                            if (nth > 1) selector += `:nth-of-type(${nth})`;
                        }
                        path.unshift(selector);
                        current = current.parentElement;
                    }
                    return path.join(' > ') || el.tagName.toLowerCase();
                } catch(err) {
                    return (el.tagName || 'element').toLowerCase();
                }
            }

            function getXPath(el) {
                if (!el || el.nodeType !== Node.ELEMENT_NODE) return '';
                try {
                    const id = getSafeId(el);
                    if (id) return `//*[@id="${id}"]`;
                    const parts = [];
                    while (el && el.nodeType === Node.ELEMENT_NODE) {
                        let index = 1;
                        let sibling = el.previousSibling;
                        while (sibling) {
                            if (sibling.nodeType === Node.ELEMENT_NODE && sibling.nodeName === el.nodeName) {
                                index++;
                            }
                            sibling = sibling.previousSibling;
                        }
                        const tagName = el.nodeName.toLowerCase();
                        parts.unshift(`${tagName}[${index}]`);
                        el = el.parentNode;
                    }
                    return parts.length ? '/' + parts.join('/') : '';
                } catch(e) { return ''; }
            }

            function getParentHierarchy(el) {
                const hierarchy = [];
                try {
                    let curr = el;
                    let depth = 0;
                    while (curr && curr.nodeType === Node.ELEMENT_NODE && depth < 5) {
                        let label = curr.tagName;
                        const id = getSafeId(curr);
                        const cls = getSafeClass(curr);
                        if (id) label += '#' + id;
                        else if (cls) {
                            const firstClass = cls.split(/\s+/)[0];
                            if (firstClass) label += '.' + firstClass;
                        }
                        hierarchy.unshift(label);
                        curr = curr.parentElement;
                        depth++;
                    }
                } catch(e) {}
                return hierarchy;
            }

            function extractElementData(target, event) {
                if (!target || target.nodeType !== Node.ELEMENT_NODE) return null;
                const rect = target.getBoundingClientRect ? target.getBoundingClientRect() : { left:0, top:0, width:0, height:0 };
                
                let elemX = 0, elemY = 0;
                let elemXPct = 0, elemYPct = 0;
                if (event && rect.width > 0 && rect.height > 0) {
                    elemX = Math.round(event.clientX - rect.left);
                    elemY = Math.round(event.clientY - rect.top);
                    elemXPct = parseFloat(((elemX / rect.width) * 100).toFixed(1));
                    elemYPct = parseFloat(((elemY / rect.height) * 100).toFixed(1));
                }

                const id = getSafeId(target);
                const cls = getSafeClass(target);

                return {
                    tag: target.tagName,
                    id: id || null,
                    class_name: cls || null,
                    name: target.getAttribute ? (target.getAttribute('name') || null) : null,
                    placeholder: target.getAttribute ? (target.getAttribute('placeholder') || null) : null,
                    type: target.getAttribute ? (target.getAttribute('type') || null) : null,
                    role: target.getAttribute ? (target.getAttribute('role') || null) : null,
                    aria_label: target.getAttribute ? (target.getAttribute('aria-label') || null) : null,
                    text: (target.innerText || target.textContent || '').replace(/[\r\n\t]+/g, ' ').trim().substring(0, 100),

                    value: target.value !== undefined ? String(target.value) : null,
                    bounding_rect: {
                        left: Math.round(rect.left),
                        top: Math.round(rect.top),
                        width: Math.round(rect.width),
                        height: Math.round(rect.height)
                    },
                    parent_hierarchy: getParentHierarchy(target),
                    selector: getCssSelector(target),
                    xpath: getXPath(target),
                    elem_coords: {
                        x: elemX,
                        y: elemY,
                        x_pct: elemXPct,
                        y_pct: elemYPct
                    }
                };
            }

            // Create HUD Controller Bar Overlay, Visual Pointer Cursor, and Bottom Keystroke HUD
            function createHudOverlays() {
                const parent = document.body || document.documentElement;
                if (!parent) return;

                // 1. Top-Right Recorder Control Bar
                if (!document.getElementById('py-web-tester-recorder-hud')) {
                    const hud = document.createElement('div');
                    hud.id = 'py-web-tester-recorder-hud';
                    hud.innerHTML = `
                        <style>
                            #py-web-tester-recorder-hud {
                                position: fixed !important;
                                top: 14px !important;
                                right: 14px !important;
                                z-index: 2147483647 !important;
                                background: rgba(15, 23, 42, 0.92) !important;
                                backdrop-filter: blur(12px) !important;
                                -webkit-backdrop-filter: blur(12px) !important;
                                color: #f8fafc !important;
                                border: 1px solid rgba(255, 255, 255, 0.15) !important;
                                border-radius: 14px !important;
                                padding: 10px 18px !important;
                                font-family: system-ui, -apple-system, Segoe UI, Roboto, sans-serif !important;
                                font-size: 13px !important;
                                font-weight: 500 !important;
                                box-shadow: 0 10px 30px rgba(0,0,0,0.5), 0 0 0 1px rgba(255,255,255,0.05) !important;
                                display: flex !important;
                                align-items: center !important;
                                gap: 16px !important;
                                user-select: none !important;
                                pointer-events: auto !important;
                            }
                            #py-web-tester-recorder-hud .rec-dot {
                                width: 10px;
                                height: 10px;
                                background-color: #ef4444;
                                border-radius: 50%;
                                display: inline-block;
                                box-shadow: 0 0 10px #ef4444;
                                animation: py-tester-pulse 1.2s infinite ease-in-out;
                            }
                            @keyframes py-tester-pulse {
                                0% { opacity: 1; transform: scale(1); }
                                50% { opacity: 0.3; transform: scale(0.85); }
                                100% { opacity: 1; transform: scale(1); }
                            }
                            #py-web-tester-recorder-hud .hud-btn-stop {
                                background: linear-gradient(135deg, #dc2626 0%, #991b1b 100%) !important;
                                color: #ffffff !important;
                                border: none !important;
                                padding: 7px 16px !important;
                                border-radius: 8px !important;
                                font-weight: 700 !important;
                                font-size: 12px !important;
                                letter-spacing: 0.5px !important;
                                cursor: pointer !important;
                                transition: all 0.2s ease !important;
                                box-shadow: 0 4px 12px rgba(220, 38, 38, 0.4) !important;
                            }
                            #py-web-tester-recorder-hud .hud-btn-stop:hover {
                                background: linear-gradient(135deg, #ef4444 0%, #b91c1c 100%) !important;
                                transform: translateY(-1px) !important;
                                box-shadow: 0 6px 16px rgba(239, 68, 68, 0.6) !important;
                            }
                            #py-web-tester-recorder-hud .hud-btn-stop:active {
                                transform: translateY(1px) !important;
                            }
                            #py-web-tester-recorder-hud .hud-stats {
                                display: flex;
                                align-items: center;
                                gap: 12px;
                                color: #cbd5e1;
                                font-family: monospace;
                            }
                            #py-web-tester-recorder-hud .hud-badge {
                                background: rgba(255,255,255,0.1);
                                padding: 3px 8px;
                                border-radius: 6px;
                                font-size: 11px;
                            }
                        </style>
                        <span class="rec-dot"></span>
                        <span style="color:#f1f5f9; font-weight:700;">TEST RECORDER</span>
                        <div class="hud-stats">
                            <span id="py-hud-timer">00:00</span>
                            <span class="hud-badge" id="py-hud-counter">${eventCount} Action${eventCount === 1 ? '' : 's'}</span>
                        </div>
                        <button class="hud-btn-stop" id="py-hud-stop-btn">STOP RECORDING</button>
                    `;

                    parent.appendChild(hud);

                    document.getElementById('py-hud-stop-btn').addEventListener('click', (e) => {
                        e.preventDefault();
                        e.stopPropagation();
                        emitStop();
                    });

                    setInterval(() => {
                        const elapsed = Math.floor((Date.now() - recordingStartTime) / 1000);
                        const mins = String(Math.floor(elapsed / 60)).padStart(2, '0');
                        const secs = String(elapsed % 60).padStart(2, '0');
                        const timerEl = document.getElementById('py-hud-timer');
                        if (timerEl) timerEl.textContent = `${mins}:${secs}`;
                    }, 1000);
                }

                // 2. Glowing Visual Mouse Pointer Cursor
                if (!document.getElementById('py-web-tester-cursor')) {
                    const cursor = document.createElement('div');
                    cursor.id = 'py-web-tester-cursor';
                    cursor.style.cssText = `
                        position: fixed !important;
                        top: -50px;
                        left: -50px;
                        width: 24px !important;
                        height: 24px !important;
                        border-radius: 50% !important;
                        background: rgba(255, 0, 110, 0.85) !important;
                        border: 2px solid #ffffff !important;
                        box-shadow: 0 0 14px rgba(255, 0, 110, 0.95), 0 0 6px #000 !important;
                        pointer-events: none !important;
                        z-index: 2147483647 !important;
                        transition: left 0.1s ease-out, top 0.1s ease-out, transform 0.1s ease !important;
                        transform: translate(-50%, -50%) !important;
                        display: block !important;
                    `;
                    const dot = document.createElement('div');
                    dot.style.cssText = 'width:6px; height:6px; background:#fff; border-radius:50%; margin:7px auto;';
                    cursor.appendChild(dot);
                    parent.appendChild(cursor);
                }

                // 3. Bottom Keystroke HUD Bar Overlay
                if (!document.getElementById('py-web-tester-keystroke-hud')) {
                    const keystrokeHud = document.createElement('div');
                    keystrokeHud.id = 'py-web-tester-keystroke-hud';
                    keystrokeHud.style.cssText = `
                        position: fixed !important;
                        bottom: 24px !important;
                        left: 50% !important;
                        transform: translateX(-50%) !important;
                        background: rgba(15, 17, 26, 0.94) !important;
                        color: #7dcfff !important;
                        border: 1px dashed #7dcfff !important;
                        border-radius: 10px !important;
                        padding: 10px 24px !important;
                        font-family: 'Consolas', 'Courier New', monospace !important;
                        font-size: 15px !important;
                        font-weight: bold !important;
                        box-shadow: 0 10px 30px rgba(0,0,0,0.7) !important;
                        z-index: 2147483647 !important;
                        display: none !important;
                        align-items: center !important;
                        gap: 12px !important;
                        backdrop-filter: blur(8px) !important;
                        transition: opacity 0.2s ease !important;
                    `;
                    
                    const icon = document.createElement('span');
                    icon.innerHTML = '⌨';
                    icon.style.cssText = 'font-size: 18px; color: #f7768e;';
                    
                    const textSpan = document.createElement('span');
                    textSpan.id = 'py-web-tester-hud-text';
                    textSpan.style.cssText = 'color: #a6e3a1; letter-spacing: 0.5px;';

                    keystrokeHud.appendChild(icon);
                    keystrokeHud.appendChild(textSpan);
                    parent.appendChild(keystrokeHud);
                }
            }

            let keystrokeTimeout = null;
            function showKeystrokeOverlay(msg) {
                const textSpan = document.getElementById('py-web-tester-hud-text');
                const hudEl = document.getElementById('py-web-tester-keystroke-hud');
                if (textSpan && hudEl) {
                    textSpan.textContent = msg;
                    hudEl.style.display = 'flex';
                    hudEl.style.opacity = '1';
                    if (keystrokeTimeout) clearTimeout(keystrokeTimeout);
                    keystrokeTimeout = setTimeout(() => {
                        hudEl.style.opacity = '0';
                        setTimeout(() => { hudEl.style.display = 'none'; }, 200);
                    }, 2200);
                }
            }

            function moveVisualCursor(x, y) {
                const cursorEl = document.getElementById('py-web-tester-cursor');
                if (cursorEl) {
                    cursorEl.style.left = x + 'px';
                    cursorEl.style.top = y + 'px';
                    cursorEl.style.display = 'block';
                }
            }

            function createClickRipple(x, y) {
                const ripple = document.createElement('div');
                ripple.style.cssText = `
                    position: fixed !important;
                    left: ${x}px !important;
                    top: ${y}px !important;
                    width: 10px !important;
                    height: 10px !important;
                    border-radius: 50% !important;
                    border: 2px solid #7dcfff !important;
                    background: rgba(125, 207, 255, 0.5) !important;
                    pointer-events: none !important;
                    z-index: 2147483646 !important;
                    transform: translate(-50%, -50%) scale(1) !important;
                    transition: transform 0.4s ease-out, opacity 0.4s ease-out !important;
                `;
                (document.body || document.documentElement).appendChild(ripple);
                requestAnimationFrame(() => {
                    ripple.style.transform = 'translate(-50%, -50%) scale(4.5)';
                    ripple.style.opacity = '0';
                });
                setTimeout(() => { ripple.remove(); }, 450);
            }

            // Keyboard shortcut Ctrl+Shift+S
            window.addEventListener('keydown', function(e) {
                if (e.ctrlKey && e.shiftKey && e.key.toLowerCase() === 's') {
                    e.preventDefault();
                    emitStop();
                } else if (e.key === 'Enter' || e.key === 'Tab' || e.key === 'Escape' || e.key.startsWith('Arrow')) {
                    showKeystrokeOverlay(`[Taste gedrückt]: ${e.key}`);
                }
            }, true);

            // Record Mouse & Click Events
            ['mousemove', 'click', 'dblclick', 'contextmenu'].forEach(eventType => {
                window.addEventListener(eventType, function(e) {
                    try {
                        moveVisualCursor(e.clientX, e.clientY);

                        if (eventType === 'mousemove') return;

                        createClickRipple(e.clientX, e.clientY);

                        const target = (e.composedPath && e.composedPath()[0]) || e.target;
                        if (!target) return;

                        const recHud = document.getElementById('py-web-tester-recorder-hud');
                        if (recHud && (recHud === target || recHud.contains(target))) return;

                        if (lastPendingInputPayload) {
                            emitEvent(lastPendingInputPayload);
                            lastPendingInputPayload = null;
                        }

                        let elemData = null;
                        try {
                            elemData = extractElementData(target, e);
                        } catch (err) {
                            elemData = {
                                tag: target.tagName || 'ELEMENT',
                                selector: (target.tagName || 'div').toLowerCase(),
                                text: (target.innerText || target.textContent || '').substring(0, 50)
                            };
                        }

                        const payload = {
                            event_type: eventType,
                            timestamp_iso: new Date().toISOString(),
                            timestamp_ms: Date.now(),
                            mouse: {
                                client_x: e.clientX,
                                client_y: e.clientY,
                                page_x: e.pageX,
                                page_y: e.pageY,
                                button: e.button
                            },
                            element: elemData,
                            page_url: window.location.href,
                            page_title: document.title
                        };

                        emitEvent(payload);
                    } catch (globalClickErr) {
                        console.error("Click handler error:", globalClickErr);
                    }
                }, true);
            });

            // Record Input & Change Events
            let inputTimer = null;
            ['input', 'change', 'blur'].forEach(eventType => {
                window.addEventListener(eventType, function(e) {
                    try {
                        const target = (e.composedPath && e.composedPath()[0]) || e.target;
                        if (!target) return;

                        const recHud = document.getElementById('py-web-tester-recorder-hud');
                        if (recHud && (recHud === target || recHud.contains(target))) return;

                        if (target.tagName === 'INPUT' || target.tagName === 'TEXTAREA' || target.isContentEditable) {
                            const val = target.value || target.innerText || '';
                            const fieldName = target.placeholder || target.name || target.id || 'Eingabefeld';
                            showKeystrokeOverlay(`[${fieldName}]: "${val}"`);
                        }

                        let elemData = null;
                        try {
                            elemData = extractElementData(target, e);
                        } catch (err) {
                            elemData = {
                                tag: target.tagName || 'INPUT',
                                selector: (target.tagName || 'input').toLowerCase()
                            };
                        }

                        lastPendingInputPayload = {
                            event_type: eventType === 'blur' ? 'change' : eventType,
                            timestamp_iso: new Date().toISOString(),
                            timestamp_ms: Date.now(),
                            value: target.value !== undefined ? String(target.value) : null,
                            element: elemData,
                            page_url: window.location.href,
                            page_title: document.title
                        };

                        if (eventType === 'change' || eventType === 'blur') {
                            clearTimeout(inputTimer);
                            emitEvent(lastPendingInputPayload);
                            lastPendingInputPayload = null;
                        } else {
                            clearTimeout(inputTimer);
                            inputTimer = setTimeout(() => {
                                if (lastPendingInputPayload) {
                                    emitEvent(lastPendingInputPayload);
                                    lastPendingInputPayload = null;
                                }
                            }, 200);
                        }
                    } catch (globalInputErr) {
                        console.error("Input handler error:", globalInputErr);
                    }
                }, true);
            });

            // Flush pending inputs on beforeunload
            window.addEventListener('beforeunload', function() {
                if (lastPendingInputPayload) {
                    emitEvent(lastPendingInputPayload);
                    lastPendingInputPayload = null;
                }
            });

            // Initialize DOM Overlays
            if (document.readyState === 'loading') {
                document.addEventListener('DOMContentLoaded', createHudOverlays);
            } else {
                createHudOverlays();
            }
        })();
        