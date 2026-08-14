"""
Dialog for creating and editing Routine Groups in py-web-tester PySide6 GUI.
Allows selecting multiple subroutines (including duplicate routines), reordering them
with Up/Down buttons, removing subroutines, and saving them as a named group (groups/<name>.json).
"""

from typing import List, Optional
from PySide6.QtCore import Qt, Signal
from PySide6.QtGui import QKeyEvent
from PySide6.QtWidgets import (
    QDialog, QVBoxLayout, QHBoxLayout, QLabel, QLineEdit, QTextEdit,
    QPushButton, QListWidget, QListWidgetItem, QMessageBox, QGroupBox
)

from libraries.routine_manager import RoutineManager

class GroupDialog(QDialog):
    group_saved_signal = Signal(str)

    def __init__(self, parent=None, manager: RoutineManager = None, group_to_edit: Optional[dict] = None):
        super().__init__(parent)
        self.manager = manager or RoutineManager()
        self.group_to_edit = group_to_edit

        title = f"Routinen-Gruppe bearbeiten: {group_to_edit.get('group_name')}" if group_to_edit else "Neue Routinen-Gruppe erstellen"
        self.setWindowTitle(title)
        self.resize(720, 520)

        self._init_ui()
        self._load_data()

    def _init_ui(self):
        layout = QVBoxLayout(self)

        # Header Title
        title_text = "Routinen-Gruppe definieren & anordnen"
        header = QLabel(title_text)
        header.setObjectName("HeaderTitle")
        layout.addWidget(header)

        # Group Name & Description
        form_layout = QVBoxLayout()
        form_layout.addWidget(QLabel("Gruppen-Name (erforderlich):"))
        self.name_edit = QLineEdit()
        self.name_edit.setPlaceholderText("z.B. Login_Und_Patientenaufnahme_Gruppe")
        form_layout.addWidget(self.name_edit)

        form_layout.addWidget(QLabel("Beschreibung (optional):"))
        self.desc_edit = QLineEdit()
        self.desc_edit.setPlaceholderText("Kurze Beschreibung der verknüpften Routinen...")
        form_layout.addWidget(self.desc_edit)

        layout.addLayout(form_layout)

        # Dual List Layout: Available Routines vs Selected Subroutines
        lists_layout = QHBoxLayout()

        # Available Routines List
        avail_box = QGroupBox("Verfügbare Testroutinen (Doppelklick zum Hinzufügen)")
        avail_layout = QVBoxLayout(avail_box)
        self.avail_list = QListWidget()
        self.avail_list.itemDoubleClicked.connect(self._on_avail_double_clicked)
        avail_layout.addWidget(self.avail_list)
        lists_layout.addWidget(avail_box)

        # Action Transfer Buttons
        btn_box = QVBoxLayout()
        btn_box.addStretch()
        self.add_btn = QPushButton("Hinzufügen →")
        self.add_btn.setMinimumWidth(110)
        self.add_btn.clicked.connect(self._add_selected)
        btn_box.addWidget(self.add_btn)

        self.remove_btn = QPushButton("← Entfernen")
        self.remove_btn.setMinimumWidth(110)
        self.remove_btn.clicked.connect(self._remove_selected)
        btn_box.addWidget(self.remove_btn)
        btn_box.addStretch()
        lists_layout.addLayout(btn_box)

        # Selected Subroutines List
        selected_box = QGroupBox("Enthaltene Subroutinen (Ausführungsreihenfolge)")
        selected_layout = QVBoxLayout(selected_box)
        self.selected_list = QListWidget()
        self.selected_list.itemDoubleClicked.connect(self._on_selected_double_clicked)
        selected_layout.addWidget(self.selected_list)

        # Reorder and remove buttons
        reorder_layout = QHBoxLayout()
        self.move_up_btn = QPushButton("▲ Nach oben")
        self.move_up_btn.setMinimumWidth(110)
        self.move_up_btn.clicked.connect(self._move_up)
        reorder_layout.addWidget(self.move_up_btn)

        self.move_down_btn = QPushButton("▼ Nach unten")
        self.move_down_btn.setMinimumWidth(110)
        self.move_down_btn.clicked.connect(self._move_down)
        reorder_layout.addWidget(self.move_down_btn)
        selected_layout.addLayout(reorder_layout)

        lists_layout.addWidget(selected_box)
        layout.addLayout(lists_layout)

        # Bottom Buttons
        bottom_layout = QHBoxLayout()
        cancel_btn = QPushButton("Abbrechen")
        cancel_btn.clicked.connect(self.reject)
        bottom_layout.addWidget(cancel_btn)

        bottom_layout.addStretch()

        save_btn = QPushButton("Gruppe Speichern")
        save_btn.setObjectName("AccentButton")
        save_btn.setStyleSheet("background-color: #a6e3a1; color: #11111b; font-weight: bold; padding: 6px 18px;")
        save_btn.clicked.connect(self._save_group)
        bottom_layout.addWidget(save_btn)

        layout.addLayout(bottom_layout)

    def keyPressEvent(self, event: QKeyEvent):
        if event.key() in (Qt.Key_Delete, Qt.Key_Backspace):
            if self.selected_list.hasFocus():
                self._remove_selected()
                return
        super().keyPressEvent(event)

    def _load_data(self):
        # Load available routines
        all_routines = self.manager.list_routines()
        for r in all_routines:
            item = QListWidgetItem(r.get("routine_name"))
            self.avail_list.addItem(item)

        # If editing existing group
        if self.group_to_edit:
            self.name_edit.setText(self.group_to_edit.get("group_name", ""))
            self.desc_edit.setText(self.group_to_edit.get("description", ""))
            for rname in self.group_to_edit.get("routine_names", []):
                self.selected_list.addItem(QListWidgetItem(rname))

    def _on_avail_double_clicked(self, item: QListWidgetItem):
        self.selected_list.addItem(QListWidgetItem(item.text()))

    def _on_selected_double_clicked(self, item: QListWidgetItem):
        row = self.selected_list.row(item)
        self.selected_list.takeItem(row)

    def _add_selected(self):
        selected = self.avail_list.selectedItems()
        for item in selected:
            self.selected_list.addItem(QListWidgetItem(item.text()))

    def _remove_selected(self):
        selected = self.selected_list.selectedItems()
        for item in selected:
            row = self.selected_list.row(item)
            self.selected_list.takeItem(row)

    def _move_up(self):
        curr_row = self.selected_list.currentRow()
        if curr_row > 0:
            item = self.selected_list.takeItem(curr_row)
            self.selected_list.insertItem(curr_row - 1, item)
            self.selected_list.setCurrentRow(curr_row - 1)

    def _move_down(self):
        curr_row = self.selected_list.currentRow()
        if curr_row >= 0 and curr_row < self.selected_list.count() - 1:
            item = self.selected_list.takeItem(curr_row)
            self.selected_list.insertItem(curr_row + 1, item)
            self.selected_list.setCurrentRow(curr_row + 1)

    def _save_group(self):
        name = self.name_edit.text().strip()
        desc = self.desc_edit.text().strip()

        if not name:
            QMessageBox.warning(self, "Fehler", "Bitte geben Sie einen Namen für die Gruppe ein.")
            return

        routine_names = []
        for i in range(self.selected_list.count()):
            routine_names.append(self.selected_list.item(i).text())

        if not routine_names:
            QMessageBox.warning(self, "Fehler", "Bitte fügen Sie mindestens eine Routine zu dieser Gruppe hinzu.")
            return

        self.manager.save_group(
            group_name=name,
            routine_names=routine_names,
            description=desc
        )

        QMessageBox.information(self, "Erfolg", f"Die Routinen-Gruppe '{name}' wurde erfolgreich gespeichert!")
        self.group_saved_signal.emit(name)
        self.accept()
