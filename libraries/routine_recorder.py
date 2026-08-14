"""
Interactive Test Routine Recorder for py-web-tester.
Launches an interactive browser, captures user actions (clicks, inputs, keypresses, navigation)
along with precise coordinates, timestamps, and page/DOM structures until Stop is pressed.
Uses CDP console stream and persistent sessionStorage counter for 100% loss-free event recording across page reloads and navigations.
"""

import os
import sys
import time
import json
from datetime import datetime
from pathlib import Path
from typing import Dict, List, Any, Optional

try:
    from playwright.sync_api import sync_playwright, Page, BrowserContext
except ImportError:
    sync_playwright = None

class RoutineRecorder:
    def __init__(
        self,
        output_dir: str = "routines",
        resources_dir: str = "resources/page_objects",
        tests_dir: str = "tests"
    ):
        self.output_dir = Path(output_dir).resolve()
        self.resources_dir = Path(resources_dir).resolve()
        self.tests_dir = Path(tests_dir).resolve()
        
        self.output_dir.mkdir(parents=True, exist_ok=True)
        self.resources_dir.mkdir(parents=True, exist_ok=True)
        self.tests_dir.mkdir(parents=True, exist_ok=True)

        self.recorded_events: List[Dict[str, Any]] = []
        self.start_time: float = 0.0
        self.is_recording: bool = False
        self.stop_requested: bool = False

    def get_js_recorder_script(self) -> str:
        """
        Returns JavaScript to be injected into the browser context.
        Monitors user interactions, emits CDP console events, and manages the HUD bar.
        Preserves action count and session start time in sessionStorage across page reloads.
        """
        return """
        (function() {
            if (window.__PY_WEB_TESTER_RECORDING_INITIALIZED__) return;
            window.__PY_WEB_TESTER_RECORDING_INITIALIZED__ = true;

            // Load persistent action count and start time from sessionStorage across page navigations
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
                updateHudCount();
                try {
                    console.debug("__PY_WEB_TESTER_EVENT__" + JSON.stringify(payload));
                } catch(e) {}
            }

            function emitStop() {
                try {
                    console.debug("__PY_WEB_TESTER_STOP__");
                } catch(e) {}
            }

            function getCssSelector(el) {
                if (!el || el.nodeType !== Node.ELEMENT_NODE) return '';
                if (el.id && !el.id.match(/^\\d/) && !el.id.includes(':')) {
                    return `#${CSS.escape(el.id)}`;
                }
                const testId = el.getAttribute('data-testid') || el.getAttribute('data-test') || el.getAttribute('data-cy');
                if (testId) return `[data-testid="${testId}"]`;

                const name = el.getAttribute('name');
                if (name) return `${el.tagName.toLowerCase()}[name="${name}"]`;

                const placeholder = el.getAttribute('placeholder');
                if (placeholder) return `${el.tagName.toLowerCase()}[placeholder="${placeholder}"]`;

                const ariaLabel = el.getAttribute('aria-label');
                if (ariaLabel) return `${el.tagName.toLowerCase()}[aria-label="${ariaLabel}"]`;

                const role = el.getAttribute('role');
                if (role) return `${el.tagName.toLowerCase()}[role="${role}"]`;

                const type = el.getAttribute('type');
                if (type && el.tagName === 'INPUT') return `input[type="${type}"]`;

                const text = (el.innerText || el.textContent || '').replace(/[\r\n\t]+/g, ' ').trim();
                if (text && text.length > 0 && text.length < 35 && ['BUTTON', 'A', 'SPAN', 'LABEL', 'H1', 'H2', 'H3', 'LI'].includes(el.tagName)) {
                    return `${el.tagName.toLowerCase()}:has-text("${text.replace(/"/g, '\\"')}")`;
                }


                if (el.className && typeof el.className === 'string') {
                    const validClasses = el.className.split(/\\s+/)
                        .filter(c => c && !c.includes(':') && !c.match(/^\\d/))
                        .slice(0, 2);
                    if (validClasses.length > 0) {
                        const classSelector = `${el.tagName.toLowerCase()}.${validClasses.map(c => CSS.escape(c)).join('.')}`;
                        if (document.querySelectorAll(classSelector).length === 1) {
                            return classSelector;
                        }
                    }
                }

                let path = [];
                let current = el;
                while (current && current.nodeType === Node.ELEMENT_NODE && current.tagName !== 'BODY') {
                    let selector = current.tagName.toLowerCase();
                    if (current.id && !current.id.match(/^\\d/)) {
                        selector += `#${CSS.escape(current.id)}`;
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
            }

            function getXPath(el) {
                if (!el || el.nodeType !== Node.ELEMENT_NODE) return '';
                if (el.id) return `//*[@id="${el.id}"]`;
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
            }

            function getParentHierarchy(el) {
                const hierarchy = [];
                let curr = el;
                let depth = 0;
                while (curr && curr.nodeType === Node.ELEMENT_NODE && depth < 5) {
                    let label = curr.tagName;
                    if (curr.id) label += '#' + curr.id;
                    else if (curr.className && typeof curr.className === 'string') {
                        const firstClass = curr.className.split(/\\s+/)[0];
                        if (firstClass) label += '.' + firstClass;
                    }
                    hierarchy.unshift(label);
                    curr = curr.parentElement;
                    depth++;
                }
                return hierarchy;
            }

            function extractElementData(target, event) {
                if (!target || target.nodeType !== Node.ELEMENT_NODE) return null;
                const rect = target.getBoundingClientRect();
                
                let elemX = 0, elemY = 0;
                let elemXPct = 0, elemYPct = 0;
                if (event && rect.width > 0 && rect.height > 0) {
                    elemX = Math.round(event.clientX - rect.left);
                    elemY = Math.round(event.clientY - rect.top);
                    elemXPct = parseFloat(((elemX / rect.width) * 100).toFixed(1));
                    elemYPct = parseFloat(((elemY / rect.height) * 100).toFixed(1));
                }

                return {
                    tag: target.tagName,
                    id: target.id || null,
                    class_name: target.className || null,
                    name: target.getAttribute('name') || null,
                    placeholder: target.getAttribute('placeholder') || null,
                    type: target.getAttribute('type') || null,
                    role: target.getAttribute('role') || null,
                    aria_label: target.getAttribute('aria-label') || null,
                    text: (target.innerText || target.textContent || '').trim().substring(0, 100),
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

            // Create HUD Controller Bar Overlay
            function createHudOverlay() {
                if (document.getElementById('py-web-tester-recorder-hud')) return;

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

                (document.body || document.documentElement).appendChild(hud);

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

            // Keyboard shortcut Ctrl+Shift+S
            window.addEventListener('keydown', function(e) {
                if (e.ctrlKey && e.shiftKey && e.key.toLowerCase() === 's') {
                    e.preventDefault();
                    emitStop();
                }
            }, true);

            // Record Mouse & Click Events (using composedPath to support Shadow DOM / custom elements)
            ['click', 'dblclick', 'contextmenu'].forEach(eventType => {
                window.addEventListener(eventType, function(e) {
                    const target = (e.composedPath && e.composedPath()[0]) || e.target;
                    const hud = document.getElementById('py-web-tester-recorder-hud');
                    if (hud && (hud === target || hud.contains(target))) return;

                    // Flush any pending input prior to click
                    if (lastPendingInputPayload) {
                        emitEvent(lastPendingInputPayload);
                        lastPendingInputPayload = null;
                    }

                    const elemData = extractElementData(target, e);
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
                }, true);
            });

            // Record Input & Change Events
            let inputTimer = null;
            ['input', 'change', 'blur'].forEach(eventType => {
                window.addEventListener(eventType, function(e) {
                    const target = (e.composedPath && e.composedPath()[0]) || e.target;
                    const hud = document.getElementById('py-web-tester-recorder-hud');
                    if (hud && (hud === target || hud.contains(target))) return;

                    const elemData = extractElementData(target, e);
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
                }, true);
            });

            // Flush pending inputs on beforeunload
            window.addEventListener('beforeunload', function() {
                if (lastPendingInputPayload) {
                    emitEvent(lastPendingInputPayload);
                    lastPendingInputPayload = null;
                }
            });

            // Initialize DOM HUD
            if (document.readyState === 'loading') {
                document.addEventListener('DOMContentLoaded', createHudOverlay);
            } else {
                createHudOverlay();
            }
        })();
        """

    def record_routine(
        self,
        start_url: str = "https://example.com",
        routine_name: str = "interactive_routine",
        headless: bool = False,
        timeout_seconds: int = 0
    ) -> Dict[str, Any]:
        """
        Launches Playwright, opens start_url, injects recorder & HUD, and records all user interactions.
        Returns dictionary with saved JSON routine file, generated Robot resource file, and test file paths.
        """
        if sync_playwright is None:
            raise RuntimeError("Playwright library is not installed! Run `uv add playwright` to enable recording.")

        self.recorded_events.clear()
        self.start_time = time.time()
        self.is_recording = True
        self.stop_requested = False

        print(f"\n=======================================================")
        print(f" [REC] INTERACTIVE TEST ROUTINE RECORDER")
        print(f" Target URL  : {start_url}")
        print(f" Routine Name: {routine_name}")
        print(f" Instructions: Perform your test steps in the browser.")
        print(f"               Click 'STOP RECORDING' in the HUD or")
        print(f"               press Ctrl+Shift+S when done.")
        print(f"=======================================================\n")

        with sync_playwright() as p:
            browser = p.chromium.launch(headless=headless, args=["--start-maximized"])
            context = browser.new_context(viewport=None)

            # Handler for Console Messages sent by browser JS
            def on_console_message(msg):
                text = msg.text
                if text.startswith("__PY_WEB_TESTER_EVENT__"):
                    try:
                        event_json_str = text[len("__PY_WEB_TESTER_EVENT__"):]
                        event_data = json.loads(event_json_str)
                        elapsed_ms = int((time.time() - self.start_time) * 1000)
                        
                        prev_ms = self.recorded_events[-1]["elapsed_ms"] if self.recorded_events else 0
                        delta_ms = elapsed_ms - prev_ms

                        event_data["action_id"] = len(self.recorded_events) + 1
                        event_data["elapsed_ms"] = elapsed_ms
                        event_data["delta_ms"] = delta_ms

                        # Deduplicate rapid duplicate events (<100ms on same element)
                        if self.recorded_events:
                            last_ev = self.recorded_events[-1]
                            if (
                                last_ev.get("event_type") == event_data.get("event_type")
                                and last_ev.get("page_url") == event_data.get("page_url")
                                and delta_ms < 100
                            ):
                                last_elem = last_ev.get("element") or {}
                                curr_elem = event_data.get("element") or {}
                                if last_elem.get("selector") == curr_elem.get("selector"):
                                    return

                        self.recorded_events.append(event_data)
                        
                        elem = event_data.get("element") or {}
                        tag = elem.get("tag", "ELEMENT")
                        selector = elem.get("selector", "")
                        evt_type = event_data.get("event_type", "").upper()
                        print(f"  [REC #{event_data['action_id']:02d}] {evt_type:6s} -> {tag} ({selector})")
                    except Exception as ex:
                        print(f"Error recording console event: {ex}", file=sys.stderr)
                elif text.startswith("__PY_WEB_TESTER_STOP__"):
                    print("\n[STOP] Stop recording signal received!")
                    self.stop_requested = True
                    self.is_recording = False

            # Attach console listener to every page opened in context
            context.on("page", lambda new_p: new_p.on("console", on_console_message))

            # Inject script on every new document
            context.add_init_script(self.get_js_recorder_script())

            page = context.new_page()
            page.on("console", on_console_message)

            # Automatic navigation listener
            def on_frame_navigated(frame):
                if frame == page.main_frame:
                    url = frame.url
                    if url and url != "about:blank":
                        elapsed_ms = int((time.time() - self.start_time) * 1000)
                        if not self.recorded_events or self.recorded_events[-1].get("page_url") != url or self.recorded_events[-1].get("event_type") != "navigate":
                            nav_event = {
                                "action_id": len(self.recorded_events) + 1,
                                "event_type": "navigate",
                                "timestamp_iso": datetime.now().isoformat(),
                                "timestamp_ms": int(time.time() * 1000),
                                "elapsed_ms": elapsed_ms,
                                "delta_ms": elapsed_ms - (self.recorded_events[-1]["elapsed_ms"] if self.recorded_events else 0),
                                "page_url": url,
                                "page_title": page.title() if not page.is_closed() else "",
                                "element": None
                            }
                            self.recorded_events.append(nav_event)
                            print(f"  [REC #{nav_event['action_id']:02d}] NAVIGATE -> {url}")

            page.on("framenavigated", on_frame_navigated)
            page.goto(start_url)

            # Wait loop until user clicks STOP or time expires
            loop_start = time.time()
            try:
                while not self.stop_requested and page.is_closed() is False:
                    page.wait_for_timeout(200)
                    if timeout_seconds > 0 and (time.time() - loop_start) > timeout_seconds:
                        print(f"Timeout reached ({timeout_seconds}s). Stopping recording.")
                        break
            except Exception:
                # Browser might be closed manually by user
                pass

            try:
                if not page.is_closed():
                    page.close()
                browser.close()
            except Exception:
                pass

        # Package recorded session into JSON
        total_duration_ms = int((time.time() - self.start_time) * 1000)
        routine_data = {
            "routine_name": routine_name,
            "recorded_at": datetime.now().isoformat(),
            "start_url": start_url,
            "duration_ms": total_duration_ms,
            "total_actions": len(self.recorded_events),
            "actions": self.recorded_events
        }

        # Save JSON file
        json_file_path = self.output_dir / f"{routine_name}.json"
        with open(json_file_path, "w", encoding="utf-8") as f:
            json.dump(routine_data, f, indent=2, ensure_ascii=False)

        print(f"\n[OK] Routine successfully saved to: {json_file_path}")

        # Automatically convert JSON into Robot Framework Resource & Test files
        from libraries.routine_converter import RoutineConverter
        converter = RoutineConverter(
            resources_dir=self.resources_dir,
            tests_dir=self.tests_dir
        )
        conversion_result = converter.convert_json_to_resource_and_test(json_file_path)

        result_summary = {
            "json_path": str(json_file_path),
            "resource_path": conversion_result["resource_path"],
            "test_path": conversion_result["test_path"],
            "total_actions": len(self.recorded_events),
            "duration_ms": total_duration_ms
        }
        return result_summary
