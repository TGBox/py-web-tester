"""
Interactive 4-Step Routine Creation Wizard for py-web-tester.
Step 1: Input Metadata (Name, URL, Description, Tags)
Step 2: Interactive Browser Recording (Launches RoutineRecorder with CDP capture)
Step 3: Preview Recorded Action Steps
Step 4: Save JSON & Convert to Robot Framework Resource/Robot files
"""

import sys
import threading
from pathlib import Path
from PySide6.QtCore import Qt, QThread, Signal, Slot
from PySide6.QtWidgets import (
    QDialog, QVBoxLayout, QHBoxLayout, QLabel, QLineEdit, QTextEdit,
    QPushButton, QStackedWidget, QWidget, QTableWidget, QTableWidgetItem,
    QHeaderView, QMessageBox, QProgressBar
)

from libraries.routine_recorder import RoutineRecorder
from libraries.routine_converter import RoutineConverter
from libraries.routine_manager import RoutineManager

class RecorderThread(QThread):
    finished_signal = Signal(dict)
    error_signal = Signal(str)

    def __init__(self, routine_name: str, target_url: str):
        super().__init__()
        self.routine_name = routine_name
        self.target_url = target_url

    def run(self):
        try:
            recorder = RoutineRecorder()
            data = recorder.record_routine(
                routine_name=self.routine_name,
                start_url=self.target_url
            )
            if not data:
                data = recorder.get_last_trace()
            self.finished_signal.emit(data)
        except Exception as e:
            self.error_signal.emit(str(e))

class RoutineWizardDialog(QDialog):
    wizard_completed_signal = Signal(str)  # Emits routine name when saved

    def __init__(self, parent=None, manager: RoutineManager = None):
        super().__init__(parent)
        self.manager = manager or RoutineManager()
        self.converter = RoutineConverter()
        
        self.setWindowTitle("Neue Testroutine definieren - Wizard")
        self.resize(780, 540)
        self.setMinimumSize(680, 480)

        self.recorded_trace_data = None
        self.recorder_thread = None

        self._init_ui()

    def _init_ui(self):
        main_layout = QVBoxLayout(self)
        main_layout.setContentsMargins(14, 14, 14, 14)
        main_layout.setSpacing(10)

        # Wizard Title Header
        self.title_label = QLabel("Schritt 1: Metadaten der neuen Routine eingeben")
        self.title_label.setObjectName("HeaderTitle")
        main_layout.addWidget(self.title_label)

        # Stacked Widget for Wizard Steps
        self.stacked_widget = QStackedWidget()
        main_layout.addWidget(self.stacked_widget)

        # Build Wizard Step Pages
        self.step1_widget = self._create_step1_metadata()
        self.step2_widget = self._create_step2_recording()
        self.step3_widget = self._create_step3_preview()

        self.stacked_widget.addWidget(self.step1_widget)
        self.stacked_widget.addWidget(self.step2_widget)
        self.stacked_widget.addWidget(self.step3_widget)

        # Bottom Button Bar
        button_layout = QHBoxLayout()
        self.cancel_btn = QPushButton("Abbrechen")
        self.cancel_btn.setMinimumWidth(110)
        self.cancel_btn.clicked.connect(self.reject)
        button_layout.addWidget(self.cancel_btn)

        button_layout.addStretch()

        self.back_btn = QPushButton("Zurück")
        self.back_btn.setMinimumWidth(110)
        self.back_btn.setEnabled(False)
        self.back_btn.clicked.connect(self._go_back)
        button_layout.addWidget(self.back_btn)

        self.next_btn = QPushButton("Weiter zu Aufnahme")
        self.next_btn.setObjectName("PrimaryButton")
        self.next_btn.setMinimumWidth(180)
        self.next_btn.clicked.connect(self._go_next)
        button_layout.addWidget(self.next_btn)

        main_layout.addLayout(button_layout)

    # -------------------------------------------------------------------------
    # WIZARD STEP PAGES
    # -------------------------------------------------------------------------

    def _create_step1_metadata(self) -> QWidget:
        widget = QWidget()
        layout = QVBoxLayout(widget)

        # Routine Name
        layout.addWidget(QLabel("Routinen-Name (erforderlich):"))
        self.name_edit = QLineEdit()
        self.name_edit.setPlaceholderText("z.B. login_instanz_dr")
        layout.addWidget(self.name_edit)

        # Target Web Page URL
        layout.addWidget(QLabel("Ziel-URL der Webseite (erforderlich):"))
        self.url_edit = QLineEdit("https://dr.data-al.cloud")
        self.url_edit.setPlaceholderText("https://example.com")
        layout.addWidget(self.url_edit)

        # Description (Optional)
        layout.addWidget(QLabel("Beschreibung (optional):"))
        self.desc_edit = QTextEdit()
        self.desc_edit.setPlaceholderText("Kurze Beschreibung der durchgeführten Schritte...")
        self.desc_edit.setMaximumHeight(80)
        layout.addWidget(self.desc_edit)

        # Tags (Optional)
        layout.addWidget(QLabel("Tags für spätere Filterung (optional, kommagetrennt):"))
        self.tags_edit = QLineEdit()
        self.tags_edit.setPlaceholderText("z.B. login, smoke, patienten, dr-cloud")
        layout.addWidget(self.tags_edit)

        layout.addStretch()
        return widget

    def _create_step2_recording(self) -> QWidget:
        widget = QWidget()
        layout = QVBoxLayout(widget)

        info_label = QLabel(
            "Klicken Sie unten auf 'Browser-Aufnahme starten'.\n\n"
            "Es öffnet sich ein interaktives Chromium-Fenster mit einer HUD-Steuerleiste.\n"
            "Führen Sie alle Klicks und Formulareingaben durch und klicken Sie in der HUD-Leiste auf 'STOP RECORDING' (oder Shift+Ctrl+S).\n"
            "Danach werden die Aktionen automatisch hierher geladen."
        )
        info_label.setWordWrap(True)
        layout.addWidget(info_label)

        self.record_status_label = QLabel("Status: Bereit für Aufnahme.")
        self.record_status_label.setStyleSheet("color: #89b4fa; font-weight: bold;")
        self.record_status_label.setWordWrap(True)
        layout.addWidget(self.record_status_label)

        self.start_rec_btn = QPushButton("● Browser-Aufnahme starten")
        self.start_rec_btn.setObjectName("PrimaryButton")
        self.start_rec_btn.setMinimumWidth(220)
        self.start_rec_btn.clicked.connect(self._start_browser_recording)
        layout.addWidget(self.start_rec_btn)

        layout.addStretch()
        return widget

    def _create_step3_preview(self) -> QWidget:
        widget = QWidget()
        layout = QVBoxLayout(widget)

        self.summary_label = QLabel("Aufgenommene Interaktionen:")
        self.summary_label.setWordWrap(True)
        layout.addWidget(self.summary_label)

        self.preview_table = QTableWidget()
        self.preview_table.setColumnCount(4)
        self.preview_table.setHorizontalHeaderLabels(["#", "Event", "Element / Selector", "Wert / Text"])
        
        header = self.preview_table.horizontalHeader()
        header.setSectionResizeMode(0, QHeaderView.ResizeToContents)
        header.setSectionResizeMode(1, QHeaderView.ResizeToContents)
        header.setSectionResizeMode(2, QHeaderView.Stretch)
        header.setSectionResizeMode(3, QHeaderView.Stretch)

        layout.addWidget(self.preview_table)

        return widget

    # -------------------------------------------------------------------------
    # NAVIGATION LOGIC
    # -------------------------------------------------------------------------

    def _go_next(self):
        curr_idx = self.stacked_widget.currentIndex()

        if curr_idx == 0:
            # Validate Step 1 metadata
            routine_name = self.name_edit.text().strip()
            url = self.url_edit.text().strip()

            if not routine_name:
                QMessageBox.warning(self, "Fehler", "Bitte geben Sie einen Namen für die Routine ein.")
                return
            if not url or not url.startswith("http"):
                QMessageBox.warning(self, "Fehler", "Bitte geben Sie eine gültige Webseiten-URL ein.")
                return

            self.stacked_widget.setCurrentIndex(1)
            self.title_label.setText("Schritt 2: Interaktive Browser-Aufnahme durchführen")
            self.back_btn.setEnabled(True)
            self.next_btn.setText("Weiter zur Vorschau")
            self.next_btn.setEnabled(False)

        elif curr_idx == 1:
            if not self.recorded_trace_data or not self.recorded_trace_data.get("actions"):
                QMessageBox.warning(self, "Keine Aktionen", "Es wurden noch keine Aktionen aufgenommen.")
                return

            self._populate_preview_table()
            self.stacked_widget.setCurrentIndex(2)
            self.title_label.setText("Schritt 3: Vorschau & Speichern der Routine")
            self.next_btn.setText("Routine Speichern")
            self.next_btn.setObjectName("AccentButton")
            self.next_btn.setStyleSheet("background-color: #a6e3a1; color: #11111b; font-weight: bold;")
            self.next_btn.setEnabled(True)

        elif curr_idx == 2:
            self._save_routine_and_convert()

    def _go_back(self):
        curr_idx = self.stacked_widget.currentIndex()
        if curr_idx > 0:
            self.stacked_widget.setCurrentIndex(curr_idx - 1)
            if self.stacked_widget.currentIndex() == 0:
                self.title_label.setText("Schritt 1: Metadaten der neuen Routine eingeben")
                self.back_btn.setEnabled(False)
                self.next_btn.setText("Weiter zu Aufnahme")
                self.next_btn.setEnabled(True)
            elif self.stacked_widget.currentIndex() == 1:
                self.title_label.setText("Schritt 2: Interaktive Browser-Aufnahme durchführen")
                self.next_btn.setText("Weiter zur Vorschau")

    # -------------------------------------------------------------------------
    # RECORDING & SAVING LOGIC
    # -------------------------------------------------------------------------

    def _start_browser_recording(self):
        routine_name = self.name_edit.text().strip()
        url = self.url_edit.text().strip()

        self.start_rec_btn.setEnabled(False)
        self.record_status_label.setText("Status: Browser wird geöffnet... Bitte Interaktionen im Browser durchführen!")
        self.record_status_label.setStyleSheet("color: #f9e2af; font-weight: bold;")

        self.recorder_thread = RecorderThread(routine_name, url)
        self.recorder_thread.finished_signal.connect(self._on_recording_finished)
        self.recorder_thread.error_signal.connect(self._on_recording_error)
        self.recorder_thread.start()

    @Slot(dict)
    def _on_recording_finished(self, trace_data: dict):
        self.recorded_trace_data = trace_data
        actions_count = trace_data.get("total_actions", len(trace_data.get("actions", [])))
        duration_sec = round(trace_data.get("duration_ms", 0) / 1000.0, 1)

        self.record_status_label.setText(
            f"Erfolg! {actions_count} Aktionen aufgenommen ({duration_sec}s)."
        )
        self.record_status_label.setStyleSheet("color: #a6e3a1; font-weight: bold;")
        self.start_rec_btn.setEnabled(True)
        self.start_rec_btn.setText("● Aufnahme erneut starten")
        self.next_btn.setEnabled(True)

    @Slot(str)
    def _on_recording_error(self, err_msg: str):
        self.record_status_label.setText(f"Fehler bei der Aufnahme: {err_msg}")
        self.record_status_label.setStyleSheet("color: #f38ba8; font-weight: bold;")
        self.start_rec_btn.setEnabled(True)

    def _populate_preview_table(self):
        if not self.recorded_trace_data:
            return

        actions = self.recorded_trace_data.get("actions", [])
        self.preview_table.setRowCount(len(actions))

        for idx, act in enumerate(actions):
            elem = act.get("element") or {}
            sel = elem.get("selector") or act.get("page_url") or ""
            val = act.get("value") or elem.get("text") or ""

            self.preview_table.setItem(idx, 0, QTableWidgetItem(str(act.get("action_id", idx + 1))))
            self.preview_table.setItem(idx, 1, QTableWidgetItem(str(act.get("event_type", ""))))
            self.preview_table.setItem(idx, 2, QTableWidgetItem(str(sel)))
            self.preview_table.setItem(idx, 3, QTableWidgetItem(str(val)))

        duration_sec = round(self.recorded_trace_data.get("duration_ms", 0) / 1000.0, 1)
        self.summary_label.setText(
            f"Vorschau der aufgenommenen Routine '{self.name_edit.text()}': "
            f"{len(actions)} Aktionen ({duration_sec}s Dauer)."
        )

    def _save_routine_and_convert(self):
        routine_name = self.name_edit.text().strip()
        url = self.url_edit.text().strip()
        desc = self.desc_edit.toPlainText().strip()
        tags_raw = self.tags_edit.text().strip()
        tags = [t.strip() for t in tags_raw.split(",") if t.strip()]

        actions = self.recorded_trace_data.get("actions", []) if self.recorded_trace_data else []
        duration_ms = self.recorded_trace_data.get("duration_ms", 0) if self.recorded_trace_data else 0

        # Save JSON routine file
        json_path = self.manager.save_routine(
            routine_name=routine_name,
            actions=actions,
            start_url=url,
            description=desc,
            tags=tags,
            duration_ms=duration_ms
        )

        # Convert to Robot Framework Resource and Test Suite
        try:
            self.converter.convert_json_to_resource_and_test(json_path)
            QMessageBox.information(
                self,
                "Erfolg",
                f"Die Routine '{routine_name}' wurde erfolgreich gespeichert und konvertiert!\n\n"
                f"• JSON Trace: routines/{routine_name}.json\n"
                f"• Resource: resources/page_objects/{routine_name}.resource\n"
                f"• Robot Suite: tests/test_{routine_name}.robot"
            )
            self.wizard_completed_signal.emit(routine_name)
            self.accept()
        except Exception as e:
            QMessageBox.critical(self, "Fehler bei Konvertierung", f"Fehler beim Erstellen der Testdateien: {e}")
