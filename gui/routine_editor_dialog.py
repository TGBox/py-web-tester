"""
Routine Editor Dialog for py-web-tester.
Allows inspecting, editing, deleting, reordering, and describing individual action steps
of an existing routine, with automatic regeneration of Robot Framework resources & test suites.
"""

from PySide6.QtCore import Signal
from PySide6.QtWidgets import (
    QDialog, QVBoxLayout, QHBoxLayout, QLabel, QPushButton,
    QMessageBox, QFrame
)

from libraries.routine_manager import RoutineManager
from libraries.routine_converter import RoutineConverter
from gui.step_table_widget import StepTableWidget

class RoutineEditorDialog(QDialog):
    routine_updated_signal = Signal(str)  # Emits routine name when updated

    def __init__(self, routine_name: str, parent=None, manager: RoutineManager = None):
        super().__init__(parent)
        self.routine_name = routine_name
        self.manager = manager or RoutineManager()
        self.converter = RoutineConverter()

        self.setWindowTitle(f"Schritte bearbeiten — Routine: {routine_name}")
        self.resize(880, 600)
        self.setMinimumSize(740, 500)

        self.routine_data = self.manager.get_routine(self.routine_name)
        self._init_ui()

    def _init_ui(self):
        main_layout = QVBoxLayout(self)
        main_layout.setContentsMargins(14, 14, 14, 14)
        main_layout.setSpacing(10)

        if not self.routine_data:
            main_layout.addWidget(QLabel(f"Fehler: Routine '{self.routine_name}' konnte nicht geladen werden."))
            return

        # Header Info Bar
        header_frame = QFrame()
        header_frame.setObjectName("HeaderBar")
        header_layout = QVBoxLayout(header_frame)
        header_layout.setContentsMargins(10, 8, 10, 8)

        title_lbl = QLabel(f"Aktionsschritte der Routine '{self.routine_name}' bearbeiten")
        title_lbl.setObjectName("HeaderTitle")
        header_layout.addWidget(title_lbl)

        url_str = self.routine_data.get("start_url", "")
        desc_str = self.routine_data.get("description", "")
        tags_str = ", ".join(self.routine_data.get("tags", [])) or "-"

        info_lbl = QLabel(f"<b>Start-URL:</b> {url_str} | <b>Tags:</b> {tags_str}")
        info_lbl.setStyleSheet("color: #a6adc8;")
        header_layout.addWidget(info_lbl)

        main_layout.addWidget(header_frame)

        # Instructions
        instr_lbl = QLabel(
            "Hier können Sie einzelne Aktionen aus der Routine löschen, deren Reihenfolge verschieben "
            "oder benutzerdefinierte Schritt-Beschreibungen hinzufügen."
        )
        instr_lbl.setWordWrap(True)
        main_layout.addWidget(instr_lbl)

        # Step Table Widget
        self.step_table = StepTableWidget()
        actions = self.routine_data.get("actions", [])
        self.step_table.set_actions(actions)
        main_layout.addWidget(self.step_table, stretch=1)

        # Button Bar
        btn_layout = QHBoxLayout()

        self.cancel_btn = QPushButton("Abbrechen")
        self.cancel_btn.setMinimumWidth(110)
        self.cancel_btn.clicked.connect(self.reject)
        btn_layout.addWidget(self.cancel_btn)

        btn_layout.addStretch()

        self.save_btn = QPushButton("💾 Speichern & Test neu generieren")
        self.save_btn.setObjectName("AccentButton")
        self.save_btn.setStyleSheet("background-color: #a6e3a1; color: #11111b; font-weight: bold; padding: 8px 18px;")
        self.save_btn.setMinimumWidth(220)
        self.save_btn.clicked.connect(self._save_changes)
        btn_layout.addWidget(self.save_btn)

        main_layout.addLayout(btn_layout)

    def _save_changes(self):
        if not self.routine_data:
            return

        updated_actions = self.step_table.get_actions()

        # Update JSON file
        success = self.manager.update_routine_actions(self.routine_name, updated_actions)
        if not success:
            QMessageBox.critical(self, "Fehler beim Speichern", f"Die Routine '{self.routine_name}' konnte nicht gespeichert werden.")
            return

        # Regenerate Robot Resource and Test files
        json_path = self.manager.routines_dir / f"{self.routine_name}.json"
        try:
            self.converter.convert_json_to_resource_and_test(json_path)
            QMessageBox.information(
                self,
                "Erfolgreich gespeichert",
                f"Die Schritte der Routine '{self.routine_name}' wurden aktualisiert ({len(updated_actions)} Aktionen).\n\n"
                f"Die Robot Framework Testdateien wurden erfolgreich neu generiert!"
            )
            self.routine_updated_signal.emit(self.routine_name)
            self.accept()
        except Exception as e:
            QMessageBox.critical(
                self,
                "Fehler bei Test-Generierung",
                f"Die JSON-Datei wurde gespeichert, aber beim Generieren der Robot-Dateien trat ein Fehler auf: {e}"
            )
