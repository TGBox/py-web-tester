"""
Reusable StepTableWidget for py-web-tester.
Provides a rich table view for routine action steps with features:
- Interactive row deletion (Delete button, Context Menu, Delete key)
- Row reordering (Move Up / Move Down)
- Single step inline description editing
- Multi-row group description assignment
"""

from typing import List, Dict, Any
from PySide6.QtCore import Qt, Signal
from PySide6.QtGui import QKeySequence, QShortcut
from PySide6.QtWidgets import (
    QWidget, QVBoxLayout, QHBoxLayout, QPushButton, QTableWidget,
    QTableWidgetItem, QHeaderView, QAbstractItemView, QInputDialog,
    QMenu, QMessageBox
)

class StepTableWidget(QWidget):
    actions_changed_signal = Signal()

    def __init__(self, parent=None):
        super().__init__(parent)
        self.actions: List[Dict[str, Any]] = []
        self._init_ui()

    def _init_ui(self):
        layout = QVBoxLayout(self)
        layout.setContentsMargins(0, 0, 0, 0)
        layout.setSpacing(8)

        # Toolbar
        toolbar_layout = QHBoxLayout()
        toolbar_layout.setSpacing(8)

        self.delete_btn = QPushButton("🗑 Schritt(e) löschen")
        self.delete_btn.setToolTip("Markierte Schritte aus der Liste entfernen (auch per Entf-Taste)")
        self.delete_btn.clicked.connect(self.delete_selected_steps)
        toolbar_layout.addWidget(self.delete_btn)

        self.up_btn = QPushButton("⬆ Nach oben")
        self.up_btn.setToolTip("Markierten Schritt nach oben verschieben")
        self.up_btn.clicked.connect(self.move_selected_up)
        toolbar_layout.addWidget(self.up_btn)

        self.down_btn = QPushButton("⬇ Nach unten")
        self.down_btn.setToolTip("Markierten Schritt nach unten verschieben")
        self.down_btn.clicked.connect(self.move_selected_down)
        toolbar_layout.addWidget(self.down_btn)

        self.group_desc_btn = QPushButton("🏷 Gruppe beschreiben")
        self.group_desc_btn.setToolTip("Allen markierten Schritten eine gemeinsame Beschreibung zuweisen")
        self.group_desc_btn.clicked.connect(self.set_group_description)
        toolbar_layout.addWidget(self.group_desc_btn)

        toolbar_layout.addStretch()
        layout.addLayout(toolbar_layout)

        # Table Widget
        self.table = QTableWidget()
        self.table.setColumnCount(5)
        self.table.setHorizontalHeaderLabels([
            "#", "Event", "Element / Selector", "Wert / Text", "Beschreibung / Kommentar"
        ])
        self.table.setSelectionBehavior(QAbstractItemView.SelectRows)
        self.table.setSelectionMode(QAbstractItemView.ExtendedSelection)
        self.table.setContextMenuPolicy(Qt.CustomContextMenu)
        self.table.customContextMenuRequested.connect(self._show_context_menu)

        header = self.table.horizontalHeader()
        header.setSectionResizeMode(0, QHeaderView.ResizeToContents)
        header.setSectionResizeMode(1, QHeaderView.ResizeToContents)
        header.setSectionResizeMode(2, QHeaderView.Stretch)
        header.setSectionResizeMode(3, QHeaderView.Stretch)
        header.setSectionResizeMode(4, QHeaderView.Stretch)

        self.table.itemChanged.connect(self._on_item_changed)
        layout.addWidget(self.table)

        # Keyboard Shortcut: Delete Key
        self.shortcut_delete = QShortcut(QKeySequence.Delete, self.table)
        self.shortcut_delete.activated.connect(self.delete_selected_steps)

    def set_actions(self, actions: List[Dict[str, Any]]):
        """Loads a list of action step dictionaries into the table."""
        self.actions = [dict(act) for act in actions]
        self._populate_table()

    def get_actions(self) -> List[Dict[str, Any]]:
        """Returns the current list of action step dictionaries with updated descriptions."""
        self._sync_descriptions_from_table()
        return self.actions

    def _populate_table(self):
        self.table.blockSignals(True)
        self.table.setRowCount(len(self.actions))

        for idx, act in enumerate(self.actions):
            elem = act.get("element") or {}
            sel = elem.get("selector") or act.get("page_url") or ""
            val = act.get("value") or elem.get("text") or ""
            desc = act.get("description") or act.get("custom_description") or act.get("comment") or ""

            # Step Number (Read-only)
            item_id = QTableWidgetItem(str(idx + 1))
            item_id.setFlags(item_id.flags() & ~Qt.ItemIsEditable)

            # Event Type (Read-only)
            item_event = QTableWidgetItem(str(act.get("event_type", "")))
            item_event.setFlags(item_event.flags() & ~Qt.ItemIsEditable)

            # Selector (Read-only)
            item_sel = QTableWidgetItem(str(sel))
            item_sel.setFlags(item_sel.flags() & ~Qt.ItemIsEditable)

            # Value (Read-only)
            item_val = QTableWidgetItem(str(val))
            item_val.setFlags(item_val.flags() & ~Qt.ItemIsEditable)

            # Description (Editable)
            item_desc = QTableWidgetItem(str(desc))
            item_desc.setToolTip("Klicken, um eine benutzerdefinierte Beschreibung einzugeben")

            self.table.setItem(idx, 0, item_id)
            self.table.setItem(idx, 1, item_event)
            self.table.setItem(idx, 2, item_sel)
            self.table.setItem(idx, 3, item_val)
            self.table.setItem(idx, 4, item_desc)

        self.table.blockSignals(False)

    def _sync_descriptions_from_table(self):
        for row in range(self.table.rowCount()):
            item_desc = self.table.item(row, 4)
            if item_desc and row < len(self.actions):
                desc_text = item_desc.text().strip()
                self.actions[row]["description"] = desc_text

    def _on_item_changed(self, item: QTableWidgetItem):
        if item.column() == 4:
            row = item.row()
            if 0 <= row < len(self.actions):
                self.actions[row]["description"] = item.text().strip()
                self.actions_changed_signal.emit()

    def get_selected_rows(self) -> List[int]:
        selected_indexes = self.table.selectionModel().selectedRows()
        rows = sorted(list(set(idx.row() for idx in selected_indexes)))
        return rows

    def delete_selected_steps(self):
        rows = self.get_selected_rows()
        if not rows:
            return

        # Delete rows in reverse order to preserve indexes
        for row in sorted(rows, reverse=True):
            if 0 <= row < len(self.actions):
                self.actions.pop(row)

        self._populate_table()
        self.actions_changed_signal.emit()

    def move_selected_up(self):
        rows = self.get_selected_rows()
        if not rows or rows[0] == 0:
            return

        for row in rows:
            self.actions[row - 1], self.actions[row] = self.actions[row], self.actions[row - 1]

        self._populate_table()
        # Restore selection moved up
        self.table.clearSelection()
        for row in rows:
            self.table.selectRow(row - 1)
        self.actions_changed_signal.emit()

    def move_selected_down(self):
        rows = self.get_selected_rows()
        if not rows or rows[-1] >= len(self.actions) - 1:
            return

        for row in sorted(rows, reverse=True):
            self.actions[row + 1], self.actions[row] = self.actions[row], self.actions[row + 1]

        self._populate_table()
        # Restore selection moved down
        self.table.clearSelection()
        for row in rows:
            self.table.selectRow(row + 1)
        self.actions_changed_signal.emit()

    def set_group_description(self):
        rows = self.get_selected_rows()
        if not rows:
            QMessageBox.information(
                self,
                "Keine Schritte markiert",
                "Bitte wählen Sie zuerst einen oder mehrere Schritte aus der Tabelle aus."
            )
            return

        text, ok = QInputDialog.getText(
            self,
            "Gruppenbeschreibung zuweisen",
            f"Geben Sie eine Beschreibung für die {len(rows)} markierten Schritte ein:"
        )
        if ok and text is not None:
            clean_text = text.strip()
            for row in rows:
                if 0 <= row < len(self.actions):
                    self.actions[row]["description"] = clean_text

            self._populate_table()
            # Restore selection
            self.table.clearSelection()
            for row in rows:
                self.table.selectRow(row)
            self.actions_changed_signal.emit()

    def _show_context_menu(self, pos):
        menu = QMenu(self)
        rows = self.get_selected_rows()

        if rows:
            del_action = menu.addAction(f"🗑 {len(rows)} Schritt(e) löschen")
            del_action.triggered.connect(self.delete_selected_steps)

            group_action = menu.addAction(f"🏷 Beschreibung für {len(rows)} Schritt(e) festlegen")
            group_action.triggered.connect(self.set_group_description)

            menu.addSeparator()

            up_action = menu.addAction("⬆ Nach oben verschieben")
            up_action.setEnabled(rows[0] > 0)
            up_action.triggered.connect(self.move_selected_up)

            down_action = menu.addAction("⬇ Nach unten verschieben")
            down_action.setEnabled(rows[-1] < len(self.actions) - 1)
            down_action.triggered.connect(self.move_selected_down)

        menu.exec(self.table.viewport().mapToGlobal(pos))
