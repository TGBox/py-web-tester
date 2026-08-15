from Browser import Browser

b = Browser()
b.new_browser(headless=True)
print("NO PAGE OPEN YET")
try:
    b.evaluate_javascript(None, "() => 123")
except Exception as e:
    print("CAUGHT BEFORE PAGE OPEN:", e)

b.new_page("https://example.com")
print("PAGE OPENED NOW")
try:
    res = b.evaluate_javascript(None, "() => 456")
    print("SUCCESS AFTER PAGE OPEN:", res)
except Exception as e:
    print("CAUGHT AFTER PAGE OPEN:", e)

b.close_browser()
