"""
PySide6 Graphical User Interface (GUI) Entry Point for py-web-tester.
Usage:
    python app.py
"""

import sys
from PySide6.QtWidgets import QApplication
from gui.main_window import MainWindow

def main():
    app = QApplication(sys.argv)
    window = MainWindow()
    window.show()
    sys.exit(app.exec())

if __name__ == "__main__":
    main()
