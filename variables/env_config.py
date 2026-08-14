"""
Environment and Test Execution Configuration
This file defines variables used across Robot Framework test suites.
You can override or extend these variables per environment (DEV, STAGING, PROD).
"""

# Default Target Application URLs
BASE_URL = "https://demo.playwright.dev/todomvc/#/"
LOGIN_URL = "https://the-internet.herokuapp.com/login"

# Browser Configuration
BROWSER = "chromium"  # Options: chromium, firefox, webkit
HEADLESS = True       # Set to False to watch browser interaction visually
SLOWMO = "0s"         # Delay between actions for debugging e.g. "500ms"
TIMEOUT = "10s"       # Default wait timeout for elements

# User Credentials for Demo Login Tests
DEMO_USER = "tomsmith"
DEMO_PASSWORD = "SuperSecretPassword!"
