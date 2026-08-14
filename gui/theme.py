"""
Dark mode stylesheet (QSS) and design system tokens for py-web-tester PySide6 GUI.
"""

DARK_THEME_QSS = """
/* Global Styles */
QWidget {
    background-color: #1e1e2e;
    color: #cdd6f4;
    font-family: 'Segoe UI', Arial, sans-serif;
    font-size: 13px;
}

/* Main Window & Dialogs */
QMainWindow, QDialog {
    background-color: #181825;
}

/* Header & Toolbars */
QToolBar, QFrame#HeaderBar {
    background-color: #1e1e2e;
    border-bottom: 1px solid #313244;
    padding: 8px;
}

/* Labels */
QLabel {
    color: #cdd6f4;
}

QLabel#HeaderTitle {
    font-size: 18px;
    font-weight: bold;
    color: #89b4fa;
}

QLabel#SubtitleLabel {
    font-size: 11px;
    color: #a6adc8;
}

QLabel#SmallDateBadge {
    font-size: 10px;
    color: #9399b2;
    background-color: #313244;
    border-radius: 4px;
    padding: 2px 6px;
}

/* Buttons */
QPushButton {
    background-color: #313244;
    color: #cdd6f4;
    border: 1px solid #45475a;
    border-radius: 6px;
    padding: 6px 14px;
    font-weight: 500;
}

QPushButton:hover {
    background-color: #45475a;
    border-color: #585b70;
}

QPushButton:pressed {
    background-color: #585b70;
}

QPushButton:disabled {
    background-color: #1e1e2e;
    color: #6c7086;
    border-color: #313244;
}

QPushButton#PrimaryButton {
    background-color: #89b4fa;
    color: #11111b;
    font-weight: bold;
    border: none;
}

QPushButton#PrimaryButton:hover {
    background-color: #b4befe;
}

QPushButton#PrimaryButton:pressed {
    background-color: #74c7ec;
}

QPushButton#AccentButton {
    background-color: #a6e3a1;
    color: #11111b;
    font-weight: bold;
    border: none;
}

QPushButton#AccentButton:hover {
    background-color: #94e2d5;
}

QPushButton#DangerButton {
    background-color: #f38ba8;
    color: #11111b;
    font-weight: bold;
    border: none;
}

QPushButton#DangerButton:hover {
    background-color: #eba0ac;
}

/* Text Inputs, ComboBoxes, SpinBoxes */
QLineEdit, QTextEdit, QPlainTextEdit, QComboBox, QSpinBox {
    background-color: #181825;
    color: #cdd6f4;
    border: 1px solid #45475a;
    border-radius: 6px;
    padding: 6px 10px;
    selection-background-color: #89b4fa;
    selection-color: #11111b;
}

QLineEdit:focus, QTextEdit:focus, QComboBox:focus {
    border: 1px solid #89b4fa;
}

QComboBox::drop-down {
    border: none;
    width: 24px;
}

QComboBox QAbstractItemView {
    background-color: #181825;
    color: #cdd6f4;
    border: 1px solid #45475a;
    selection-background-color: #313244;
}

/* Tabs */
QTabWidget::pane {
    border: 1px solid #313244;
    background-color: #1e1e2e;
    border-radius: 6px;
}

QTabBar::tab {
    background-color: #181825;
    color: #a6adc8;
    border: 1px solid #313244;
    padding: 8px 18px;
    margin-right: 2px;
    border-top-left-radius: 6px;
    border-top-right-radius: 6px;
    font-weight: 500;
}

QTabBar::tab:selected {
    background-color: #1e1e2e;
    color: #89b4fa;
    border-bottom-color: #1e1e2e;
    font-weight: bold;
}

QTabBar::tab:hover:!selected {
    background-color: #313244;
    color: #cdd6f4;
}

/* Tables and Tree Views */
QTableWidget, QTreeView, QListView {
    background-color: #181825;
    color: #cdd6f4;
    border: 1px solid #313244;
    gridline-color: #313244;
    border-radius: 6px;
}

QHeaderView::section {
    background-color: #1e1e2e;
    color: #89b4fa;
    padding: 6px;
    border: 1px solid #313244;
    font-weight: bold;
}

QTableWidget::item:selected, QTreeView::item:selected {
    background-color: #313244;
    color: #89b4fa;
}

/* Scrollbars */
QScrollBar:vertical {
    background-color: #181825;
    width: 10px;
    margin: 0px;
}

QScrollBar::handle:vertical {
    background-color: #45475a;
    min-height: 20px;
    border-radius: 4px;
}

QScrollBar::handle:vertical:hover {
    background-color: #585b70;
}

QScrollBar::add-line:vertical, QScrollBar::sub-line:vertical {
    height: 0px;
}

/* Progress Bar */
QProgressBar {
    background-color: #181825;
    border: 1px solid #313244;
    border-radius: 6px;
    text-align: center;
    color: #cdd6f4;
    font-weight: bold;
}

QProgressBar::chunk {
    background-color: #89b4fa;
    border-radius: 5px;
}

/* Sliders */
QSlider::groove:horizontal {
    border: 1px solid #313244;
    height: 6px;
    background-color: #181825;
    border-radius: 3px;
}

QSlider::handle:horizontal {
    background-color: #89b4fa;
    border: none;
    width: 16px;
    height: 16px;
    margin: -5px 0;
    border-radius: 8px;
}

QSlider::handle:horizontal:hover {
    background-color: #b4befe;
}

/* Group Boxes & Cards */
QGroupBox {
    border: 1px solid #313244;
    border-radius: 8px;
    margin-top: 12px;
    padding-top: 10px;
    font-weight: bold;
    color: #89b4fa;
}

QGroupBox::title {
    subcontrol-origin: margin;
    subcontrol-position: top left;
    left: 10px;
    padding: 0 5px;
}

/* Status Bar */
QStatusBar {
    background-color: #181825;
    color: #a6adc8;
    border-top: 1px solid #313244;
}
"""
