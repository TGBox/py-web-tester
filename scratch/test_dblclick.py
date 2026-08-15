from Browser import Browser

b = Browser()
b.new_browser(headless=True)
b.new_page("https://example.com")

js_dblclick = """
(el) => {
    if (!el) return;
    el.dispatchEvent(new MouseEvent('mousedown', {bubbles: true, cancelable: true, detail: 1}));
    el.dispatchEvent(new MouseEvent('mouseup', {bubbles: true, cancelable: true, detail: 1}));
    el.dispatchEvent(new MouseEvent('click', {bubbles: true, cancelable: true, detail: 1}));
    el.dispatchEvent(new MouseEvent('mousedown', {bubbles: true, cancelable: true, detail: 2}));
    el.dispatchEvent(new MouseEvent('mouseup', {bubbles: true, cancelable: true, detail: 2}));
    el.dispatchEvent(new MouseEvent('click', {bubbles: true, cancelable: true, detail: 2}));
    el.dispatchEvent(new MouseEvent('dblclick', {bubbles: true, cancelable: true, detail: 2}));
}
"""

try:
    b.evaluate_javascript("h1", js_dblclick)
    print("DBLCLICK DISPATCH SUCCESSFUL")
except Exception as e:
    print("ERROR:", e)

b.close_browser()
