"""
Dialog for assembling and editing Master Test Suites in py-web-tester PySide6 GUI.
Allows combining multiple Routine Groups and single Routines into a master test suite (suites/<name>.json).
"""

from typing import List, Optional
from PySide6.QtCore import Qt, Signal
from PySide6.QtWidgets import (
    QDialog, QVBoxLayout, QHBoxLayout, QLabel, QLineEdit,
    QPushButton, QListWidget, QListWidgetItem, QMessageBox, QGroupBox,
    QComboBox
)

from libraries.routine_manager import RoutineManager

class SuiteDialog(QDialog):
    suite_saved_signal = Signal(str)

    def __init__(self, parent=None, manager: RoutineManager = None, suite_to_edit: Optional[dict] = None):
        super().__init__(parent)
        self.manager = manager or RoutineManager()
        self.suite_to_edit = suite_to_edit

        title = f"Gesamt-Test bearbeiten: {suite_to_edit.get('suite_name')}" if suite_to_edit else "Neuen Gesamt-Test / Suite zusammenstellen"
        self.setWindowTitle(title)
        self.resize(700, 500)

        self._init_ui()
        self._load_data()

    def _init_ui(self):
        layout = QVBoxLayout(self)

        # Header Title
        header = QLabel("Gesamt-Test (Master Test Suite) zusammenstellen")
        header.setObjectName("HeaderTitle")
        layout.addWidget(header)

        # Form Layout
        form_layout = QVBoxLayout()
        form_layout.addWidget(QLabel("Suite-Name (erforderlich):"))
        self.name_edit = QLineEdit()
        self.name_edit.setPlaceholderText("z.B. Tägliche_Gesamte_Regression_Suite")
        form_layout.addWidget(self.name_edit)

        form_layout.addWidget(QLabel("Beschreibung (optional):"))
        self.desc_edit = QLineEdit()
        self.desc_edit.setPlaceholderText("Kurze Beschreibung dieses Gesamt-Tests...")
        form_layout.addWidget(self.desc_edit)

        layout.addLayout(form_layout)

        # Selection Layout
        lists_layout = QHBoxLayout()

        # Add Component Controls
        add_box = QGroupBox("Elemente hinzufügen")
        add_layout = QVBoxLayout(add_box)

        add_layout.addWidget(QLabel("Typ auswählen:"))
        self.type_combo = QComboBox()
        self.type_combo.addItems(["Routinen-Gruppe", "Einzelne Routine"])
        self.type_combo.currentIndexChanged.connect(self._on_type_changed)
        add_layout.addWidget(self.type_combo)

        add_layout.addWidget(QLabel("Verfügbares Element:"))
        self.item_combo = QComboBox()
        add_layout.addWidget(self.item_combo)

        self.add_item_btn = QPushButton("Hinzufügen →")
        self.add_item_btn.setObjectName("PrimaryButton")
        self.add_item_btn.clicked.connect(self._add_item)
        add_layout.addWidget(self.add_item_btn)

        add_layout.addStretch()
        lists_layout.addWidget(add_box)

        # Suite Components List
        suite_box = QGroupBox("Inhalt des Gesamt-Tests (Ausführungsreihenfolge)")
        suite_layout = QVBoxLayout(suite_box)
        self.suite_list = QListWidget()
        suite_layout.addWidget(self.suite_list)

        # Reorder and remove buttons
        ctrl_layout = QHBoxLayout()
        self.move_up_btn = QPushButton("▲ Oben")
        self.move_up_btn.clicked.connect(self._move_up)
        ctrl_layout.addWidget(self.move_up_btn)

        self.move_down_btn = QPushButton("▼ Unten")
        self.move_down_btn.clicked.connect(self._move_down)
        ctrl_layout.addWidget(self.move_down_btn)

        self.remove_btn = QPushButton("Entfernen")
        self.remove_btn.clicked.connect(self._remove_item)
        ctrl_layout.addWidget(self.remove_btn)
        suite_layout.addLayout(ctrl_layout)

        lists_layout.addWidget(suite_box)
        layout.addLayout(lists_layout)

        # Bottom Buttons
        bottom_layout = QHBoxLayout()
        cancel_btn = QPushButton("Abbrechen")
        cancel_btn.clicked.connect(self.reject)
        bottom_layout.addWidget(cancel_btn)

        bottom_layout.addStretch()

        save_btn = QPushButton("Gesamt-Test Speichern")
        save_btn.setObjectName("AccentButton")
        save_btn.setStyleSheet("background-color: #a6e3a1; color: #11111b; font-weight: bold;")
        save_btn.clicked.connect(self._save_suite)
        bottom_layout.addWidget(save_btn)

        layout.addLayout(bottom_layout)

    def _load_data(self):
        self._on_type_changed(0)

        if self.suite_to_edit:
            self.name_edit.setText(self.suite_to_edit.get("suite_name", ""))
            self.desc_edit.setText(self.suite_to_edit.get("description", ""))
            for item in self.suite_to_edit.get("items", []):
                itype = item.get("type", "routine")
                iname = item.get("name", "")
                display = f"[{itype.upper()}] {iname}"
                list_item = QListWidgetItem(display)
                list_item.setData(Qt.UserRole, {"type": itype, "name": iname})
                self.suite_list.addItem(list_item)

    def _on_type_changed(self, index: int):
        self.item_combo.clear()
        if index == 0:  # Routinen-Gruppe
            groups = self.manager.list_groups()
            for g in groups:
                self.item_combo.addItem(g.get("group_name"))
        else:  # Einzelne Routine
            routines = self.manager.list_routines()
            for r in routines:
                self.item_combo.addItem(r.get("routine_name"))

    def _add_item(self):
        iname = self.item_combo.currentText().strip()
        if not iname:
            return

        itype = "group" if self.type_combo.currentIndex() == 0 else "routine"
        display = f"[{itype.upper()}] {iname}"
        
        list_item = QListWidgetItem(display)
        list_item.setData(Qt.UserRole, {"type": itype, "name": iname})
        self.suite_list.addItem(list_item)

    def _remove_item(self):
        selected = self.suite_list.selectedItems()
        for item in selected:
            row = self.suite_list.row(item)
            self.suite_list.takeItem(row)

    def _move_up(self):
        curr_row = self.suite_list.currentRow()
        if curr_row > 0:
            item = self.suite_list.takeItem(curr_row)
            self.suite_list.insertItem(curr_row - 1, item)
            self.suite_list.setCurrentRow(curr_row - 1)

    def _move_down(self):
        curr_row = self.suite_list.currentRow()
        if curr_row >= 0 and curr_row < self.suite_list.count() - 1:
            item = self.suite_list.takeItem(curr_row)
            self.suite_list.insertItem(curr_row + 1, item)
            self.suite_list.setCurrentRow(curr_row + 1)

    def _save_suite(self):
        name = self.name_edit.text().strip()
        desc = self.desc_edit.text().strip()

        if not name:
            QMessageBox.warning(self, "Fehler", "Bitte geben Sie einen Namen für die Test-Suite ein.")
            return

        items = []
        for i in range(self.suite_list.count()):
            data = self.suite_list.item(i).data(Qt.UserRole)
            if data:
                items.append(data)

        if not items:
            QMessageBox.warning(self, "Fehler", "Bitte fügen Sie mindestens eine Gruppe oder Routine hinzu.")
            return

        self.manager.save_suite(
            suite_name=name,
            items=items,
            description=desc
        )

        QMessageBox.information(self, "Erfolg", f"Der Gesamt-Test '{name}' wurde erfolgreich gespeichert!")
        self.suite_saved_signal.emit(name)
        self.accept()
