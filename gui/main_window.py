"""
Main PySide6 Window for py-web-tester Desktop Application.
Features:
- Header bar with "+ Neue Routine definieren" wizard trigger, search bar, and tag filter.
- 3 Tab Views: "Einzelne Routinen", "Routinen-Gruppen", "Gesamt-Tests / Suiten".
- Selection checkboxes & batch operations across ALL 3 tabs (Multi-Selection Run & Multi-Selection Delete).
- Editing existing Groups & Master Test Suites with duplicate elements, Up/Down reordering, and item removal.
- Execution benchmark timing comparison column (Original manual baseline duration vs last automated test duration, speedup factor, and timestamp).
- Standardized German date formatting: "14.08.2026, 19:08 Uhr" across all creation dates and execution logs.
- Direct opening of generated HTML test reports (report.html / log.html) in default web browser.
- Generous auto-sizing for all table headers, labels, buttons, and combo boxes to avoid text truncation.
- Bottom Execution Control Bar:
  * Headless / Headed toggle switch.
  * Speed mode selection: Maximal (Instant ready), 2x Speed, Normal, Slow-Mo slider, Manual step-by-step.
  * Visual mouse pointer and bottom Keystroke HUD enabled for Headed tests.
  * Control buttons ("Start", "Nächster Schritt", "Stopp", "📊 Bericht öffnen").
  * Real-time Log Console Drawer with automatic duration comparison tables.
"""

import sys
from pathlib import Path
from typing import List, Dict, Any, Optional

from PySide6.QtCore import Qt, QUrl, Slot
from PySide6.QtGui import QDesktopServices, QTextCursor
from PySide6.QtWidgets import (
    QMainWindow, QWidget, QVBoxLayout, QHBoxLayout, QLabel, QLineEdit,
    QPushButton, QTabWidget, QTableWidget, QTableWidgetItem, QHeaderView,
    QCheckBox, QComboBox, QSlider, QProgressBar, QTextEdit, QFrame,
    QMessageBox, QSplitter, QGroupBox, QListWidget, QListWidgetItem, QTreeWidget, QTreeWidgetItem
)

from gui.theme import DARK_THEME_QSS
from gui.routine_wizard import RoutineWizardDialog
from gui.routine_editor_dialog import RoutineEditorDialog
from gui.group_dialog import GroupDialog
from gui.suite_dialog import SuiteDialog
from gui.execution_controller import ExecutionControllerThread

from libraries.routine_manager import RoutineManager, format_datetime_de
from libraries.routine_converter import RoutineConverter

class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.manager = RoutineManager()
        self.converter = RoutineConverter()
        self.execution_thread: Optional[ExecutionControllerThread] = None

        self.setWindowTitle("py-web-tester — Web UI Automation Suite")
        self.resize(1340, 840)
        self.setMinimumSize(1080, 720)
        self.setStyleSheet(DARK_THEME_QSS)

        self._init_ui()
        self.refresh_all_views()

    def _init_ui(self):
        central_widget = QWidget()
        self.setCentralWidget(central_widget)
        main_layout = QVBoxLayout(central_widget)
        main_layout.setContentsMargins(14, 14, 14, 14)
        main_layout.setSpacing(12)

        # 1. HEADER BAR
        header_frame = QFrame()
        header_frame.setObjectName("HeaderBar")
        header_layout = QHBoxLayout(header_frame)
        header_layout.setContentsMargins(12, 8, 12, 8)
        header_layout.setSpacing(12)

        title_box = QVBoxLayout()
        app_title = QLabel("py-web-tester")
        app_title.setObjectName("HeaderTitle")
        subtitle = QLabel("Automatisierte Web-Testroutinen & Robot Framework Suite Engine")
        subtitle.setObjectName("SubtitleLabel")
        title_box.addWidget(app_title)
        title_box.addWidget(subtitle)
        header_layout.addLayout(title_box)

        header_layout.addStretch()

        # Search Field
        self.search_edit = QLineEdit()
        self.search_edit.setPlaceholderText("🔍 Routinen / Tags / URLs suchen...")
        self.search_edit.setMinimumWidth(260)
        self.search_edit.textChanged.connect(self._on_filter_changed)
        header_layout.addWidget(self.search_edit)

        # Tag Filter Dropdown
        self.tag_combo = QComboBox()
        self.tag_combo.addItem("Alle Tags", "all")
        self.tag_combo.setMinimumWidth(160)
        self.tag_combo.setSizeAdjustPolicy(QComboBox.AdjustToContents)
        self.tag_combo.currentIndexChanged.connect(self._on_filter_changed)
        header_layout.addWidget(self.tag_combo)

        # Button: Neue Routine definieren
        self.new_routine_btn = QPushButton("+ Neue Routine definieren")
        self.new_routine_btn.setObjectName("PrimaryButton")
        self.new_routine_btn.setMinimumWidth(190)
        self.new_routine_btn.clicked.connect(self._open_new_routine_wizard)
        header_layout.addWidget(self.new_routine_btn)

        main_layout.addWidget(header_frame)

        # 2. MAIN 3-TAB VIEW
        self.tabs = QTabWidget()
        
        self.tab_routines = self._create_routines_tab()
        self.tab_groups = self._create_groups_tab()
        self.tab_suites = self._create_suites_tab()

        self.tabs.addTab(self.tab_routines, "Einzelne Routinen")
        self.tabs.addTab(self.tab_groups, "Routinen-Gruppen")
        self.tabs.addTab(self.tab_suites, "Gesamt-Tests / Suiten")

        main_layout.addWidget(self.tabs, stretch=1)

        # 3. BOTTOM EXECUTION CONTROL BAR & LOG CONSOLE
        exec_group = QGroupBox("Testausführung & Steuerung")
        exec_layout = QVBoxLayout(exec_group)
        exec_layout.setSpacing(10)

        # Controls Row
        ctrl_row = QHBoxLayout()
        ctrl_row.setSpacing(12)

        # Headless Toggle
        self.headless_cb = QCheckBox("Headless Modus")
        self.headless_cb.setChecked(False)  # Headed by default for mouse & HUD visibility
        ctrl_row.addWidget(self.headless_cb)

        ctrl_row.addSpacing(10)

        # Speed Mode Label & Combo
        speed_label = QLabel("Geschwindigkeit:")
        ctrl_row.addWidget(speed_label)
        
        self.speed_mode_combo = QComboBox()
        self.speed_mode_combo.addItem("⚡ Maximal (Sofort wenn bereit)", "MAX")
        self.speed_mode_combo.addItem("⏩ Doppelte Geschwindigkeit (2x)", "2X")
        self.speed_mode_combo.addItem("▶ Normal", "NORMAL")
        self.speed_mode_combo.addItem("🐌 Slow-Mo", "SLOWMO")
        self.speed_mode_combo.addItem("⏸ Manuell (Schritt-für-Schritt)", "MANUAL")
        self.speed_mode_combo.setCurrentIndex(2)  # Default to Normal
        self.speed_mode_combo.setMinimumWidth(280)
        self.speed_mode_combo.setSizeAdjustPolicy(QComboBox.AdjustToContents)
        self.speed_mode_combo.currentIndexChanged.connect(self._on_speed_mode_changed)
        ctrl_row.addWidget(self.speed_mode_combo)

        # Slow-Mo Slider & Label
        self.slowmo_label = QLabel("Verzögerung: 500ms")
        self.slowmo_label.setMinimumWidth(150)
        self.slowmo_label.setVisible(False)
        ctrl_row.addWidget(self.slowmo_label)

        self.slowmo_slider = QSlider(Qt.Horizontal)
        self.slowmo_slider.setRange(100, 2000)
        self.slowmo_slider.setValue(500)
        self.slowmo_slider.setFixedWidth(130)
        self.slowmo_slider.setVisible(False)
        self.slowmo_slider.valueChanged.connect(self._on_slider_value_changed)
        ctrl_row.addWidget(self.slowmo_slider)

        ctrl_row.addStretch()

        # Execution Action Buttons
        self.run_btn = QPushButton("▶ Tests Ausführen")
        self.run_btn.setObjectName("AccentButton")
        self.run_btn.setStyleSheet("background-color: #a6e3a1; color: #11111b; font-weight: bold; font-size: 13px; padding: 8px 20px;")
        self.run_btn.setMinimumWidth(160)
        self.run_btn.clicked.connect(self._start_test_execution)
        ctrl_row.addWidget(self.run_btn)

        self.next_step_btn = QPushButton("⏭ Nächster Schritt")
        self.next_step_btn.setEnabled(False)
        self.next_step_btn.setMinimumWidth(140)
        self.next_step_btn.clicked.connect(self._trigger_next_step)
        ctrl_row.addWidget(self.next_step_btn)

        self.stop_btn = QPushButton("⏹ Stopp")
        self.stop_btn.setEnabled(False)
        self.stop_btn.setMinimumWidth(100)
        self.stop_btn.clicked.connect(self._stop_execution)
        ctrl_row.addWidget(self.stop_btn)

        # Button: Report / Bericht im Browser öffnen
        self.open_report_btn = QPushButton("📊 Testbericht öffnen")
        self.open_report_btn.setStyleSheet("background-color: #89b4fa; color: #11111b; font-weight: bold; padding: 8px 16px;")
        self.open_report_btn.setMinimumWidth(160)
        self.open_report_btn.clicked.connect(self._open_test_report)
        ctrl_row.addWidget(self.open_report_btn)

        exec_layout.addLayout(ctrl_row)

        # Progress & Status Row
        status_row = QHBoxLayout()
        self.status_label = QLabel("Status: Bereit. (Visuelle Maus & Keystroke-HUD sind im Sichtbaren Modus aktiv)")
        self.status_label.setStyleSheet("color: #89b4fa; font-weight: bold;")
        self.status_label.setWordWrap(True)
        status_row.addWidget(self.status_label, stretch=1)

        self.toggle_log_btn = QPushButton("Echtzeit-Log anzeigen ▼")
        self.toggle_log_btn.setFlat(True)
        self.toggle_log_btn.setMinimumWidth(160)
        self.toggle_log_btn.clicked.connect(self._toggle_log_console)
        status_row.addWidget(self.toggle_log_btn)

        exec_layout.addLayout(status_row)

        # Real-time Log Console (Collapsible)
        self.log_console = QTextEdit()
        self.log_console.setReadOnly(True)
        self.log_console.setMaximumHeight(140)
        self.log_console.setVisible(False)
        self.log_console.setStyleSheet("font-family: Consolas, monospace; font-size: 11px; background-color: #11111b; color: #a6adc8;")
        exec_layout.addWidget(self.log_console)

        main_layout.addWidget(exec_group)

    # -------------------------------------------------------------------------
    # REPORT OPENER HELPER
    # -------------------------------------------------------------------------

    def _open_test_report(self):
        """Opens the Robot Framework HTML report (report.html or log.html) in default web browser."""
        report_file = Path("results/report.html").resolve()
        log_file = Path("results/log.html").resolve()

        target_file = report_file if report_file.exists() else log_file

        if target_file.exists():
            QDesktopServices.openUrl(QUrl.fromLocalFile(str(target_file)))
        else:
            QMessageBox.information(
                self,
                "Kein Bericht vorhanden",
                "Es wurde bisher noch kein Testbericht generiert.\n\n"
                "Bitte führen Sie zuerst eine Testroutine, Gruppe oder Suite aus!"
            )

    # -------------------------------------------------------------------------
    # TAB CREATION HELPERS
    # -------------------------------------------------------------------------

    def _create_routines_tab(self) -> QWidget:
        widget = QWidget()
        layout = QVBoxLayout(widget)

        top_bar = QHBoxLayout()
        self.run_selected_routines_btn = QPushButton("▶ Markierte Routinen ausführen")
        self.run_selected_routines_btn.setMinimumWidth(210)
        self.run_selected_routines_btn.clicked.connect(self._run_selected_routines)
        top_bar.addWidget(self.run_selected_routines_btn)

        self.create_group_from_sel_btn = QPushButton("⊞ Als Gruppe speichern")
        self.create_group_from_sel_btn.setMinimumWidth(170)
        self.create_group_from_sel_btn.clicked.connect(self._create_group_from_selection)
        top_bar.addWidget(self.create_group_from_sel_btn)

        self.delete_selected_routines_btn = QPushButton("🗑 Markierte Routinen löschen")
        self.delete_selected_routines_btn.setObjectName("DangerButton")
        self.delete_selected_routines_btn.setStyleSheet("background-color: #f38ba8; color: #11111b; font-weight: bold; padding: 6px 14px;")
        self.delete_selected_routines_btn.setMinimumWidth(200)
        self.delete_selected_routines_btn.clicked.connect(self._delete_selected_routines)
        top_bar.addWidget(self.delete_selected_routines_btn)

        top_bar.addStretch()
        layout.addLayout(top_bar)

        self.routines_table = QTableWidget()
        self.routines_table.setColumnCount(8)
        self.routines_table.setHorizontalHeaderLabels([
            "Auswahl", "Routinen-Name", "Erstellungsdatum", "Ziel-URL", "Schritte", "Dauer (Aufnahme ➔ Letzter Test)", "Tags", "Aktion"
        ])
        
        header = self.routines_table.horizontalHeader()
        header.setSectionResizeMode(0, QHeaderView.ResizeToContents)
        header.setSectionResizeMode(1, QHeaderView.Stretch)
        header.setSectionResizeMode(2, QHeaderView.ResizeToContents)
        header.setSectionResizeMode(3, QHeaderView.Stretch)
        header.setSectionResizeMode(4, QHeaderView.ResizeToContents)
        header.setSectionResizeMode(5, QHeaderView.ResizeToContents)
        header.setSectionResizeMode(6, QHeaderView.ResizeToContents)
        header.setSectionResizeMode(7, QHeaderView.ResizeToContents)
        
        self.routines_table.setSelectionBehavior(QTableWidget.SelectRows)
        layout.addWidget(self.routines_table)

        return widget

    def _create_groups_tab(self) -> QWidget:
        widget = QWidget()
        layout = QVBoxLayout(widget)

        top_bar = QHBoxLayout()
        new_group_btn = QPushButton("+ Neue Routinen-Gruppe erstellen")
        new_group_btn.setObjectName("PrimaryButton")
        new_group_btn.setMinimumWidth(230)
        new_group_btn.clicked.connect(self._open_new_group_dialog)
        top_bar.addWidget(new_group_btn)

        self.run_selected_groups_btn = QPushButton("▶ Markierte Gruppen ausführen")
        self.run_selected_groups_btn.setMinimumWidth(210)
        self.run_selected_groups_btn.clicked.connect(self._run_selected_groups)
        top_bar.addWidget(self.run_selected_groups_btn)

        self.delete_selected_groups_btn = QPushButton("🗑 Markierte Gruppen löschen")
        self.delete_selected_groups_btn.setObjectName("DangerButton")
        self.delete_selected_groups_btn.setStyleSheet("background-color: #f38ba8; color: #11111b; font-weight: bold; padding: 6px 14px;")
        self.delete_selected_groups_btn.setMinimumWidth(200)
        self.delete_selected_groups_btn.clicked.connect(self._delete_selected_groups)
        top_bar.addWidget(self.delete_selected_groups_btn)

        top_bar.addStretch()
        layout.addLayout(top_bar)

        self.groups_table = QTableWidget()
        self.groups_table.setColumnCount(6)
        self.groups_table.setHorizontalHeaderLabels([
            "Auswahl", "Gruppen-Name", "Anzahl Routinen", "Enthaltene Routinen", "Erstellt am", "Aktion"
        ])

        header = self.groups_table.horizontalHeader()
        header.setSectionResizeMode(0, QHeaderView.ResizeToContents)
        header.setSectionResizeMode(1, QHeaderView.ResizeToContents)
        header.setSectionResizeMode(2, QHeaderView.ResizeToContents)
        header.setSectionResizeMode(3, QHeaderView.Stretch)
        header.setSectionResizeMode(4, QHeaderView.ResizeToContents)
        header.setSectionResizeMode(5, QHeaderView.ResizeToContents)

        layout.addWidget(self.groups_table)

        return widget

    def _create_suites_tab(self) -> QWidget:
        widget = QWidget()
        layout = QVBoxLayout(widget)

        top_bar = QHBoxLayout()
        new_suite_btn = QPushButton("+ Neuen Gesamt-Test (Suite) erstellen")
        new_suite_btn.setObjectName("PrimaryButton")
        new_suite_btn.setMinimumWidth(250)
        new_suite_btn.clicked.connect(self._open_new_suite_dialog)
        top_bar.addWidget(new_suite_btn)

        self.run_selected_suites_btn = QPushButton("▶ Markierte Suiten ausführen")
        self.run_selected_suites_btn.setMinimumWidth(200)
        self.run_selected_suites_btn.clicked.connect(self._run_selected_suites)
        top_bar.addWidget(self.run_selected_suites_btn)

        self.delete_selected_suites_btn = QPushButton("🗑 Markierte Suiten löschen")
        self.delete_selected_suites_btn.setObjectName("DangerButton")
        self.delete_selected_suites_btn.setStyleSheet("background-color: #f38ba8; color: #11111b; font-weight: bold; padding: 6px 14px;")
        self.delete_selected_suites_btn.setMinimumWidth(200)
        self.delete_selected_suites_btn.clicked.connect(self._delete_selected_suites)
        top_bar.addWidget(self.delete_selected_suites_btn)

        top_bar.addStretch()
        layout.addLayout(top_bar)

        self.suites_table = QTableWidget()
        self.suites_table.setColumnCount(6)
        self.suites_table.setHorizontalHeaderLabels([
            "Auswahl", "Suite-Name", "Anzahl Elemente", "Beschreibung", "Erstellt am", "Aktion"
        ])

        header = self.suites_table.horizontalHeader()
        header.setSectionResizeMode(0, QHeaderView.ResizeToContents)
        header.setSectionResizeMode(1, QHeaderView.ResizeToContents)
        header.setSectionResizeMode(2, QHeaderView.ResizeToContents)
        header.setSectionResizeMode(3, QHeaderView.Stretch)
        header.setSectionResizeMode(4, QHeaderView.ResizeToContents)
        header.setSectionResizeMode(5, QHeaderView.ResizeToContents)

        layout.addWidget(self.suites_table)

        return widget

    # -------------------------------------------------------------------------
    # DATA REFRESH & POPULATION
    # -------------------------------------------------------------------------

    def refresh_all_views(self):
        self._refresh_tag_combo()
        self._refresh_routines_table()
        self._refresh_groups_table()
        self._refresh_suites_table()

    def _refresh_tag_combo(self):
        curr_tag = self.tag_combo.currentData() or "all"
        self.tag_combo.blockSignals(True)
        self.tag_combo.clear()
        self.tag_combo.addItem("Alle Tags", "all")
        
        all_tags = self.manager.get_all_tags()
        for t in all_tags:
            self.tag_combo.addItem(f"🏷 {t}", t)

        idx = self.tag_combo.findData(curr_tag)
        if idx >= 0:
            self.tag_combo.setCurrentIndex(idx)
        self.tag_combo.blockSignals(False)

    def _refresh_routines_table(self):
        search_query = self.search_edit.text().strip()
        tag_filter = self.tag_combo.currentData() or "all"

        routines = self.manager.filter_routines(search_text=search_query, tag_filter=tag_filter)
        self.routines_table.setRowCount(len(routines))

        for idx, r in enumerate(routines):
            name = r.get("routine_name", "")
            date_str = r.get("formatted_date", format_datetime_de(r.get("recorded_at")))
            url = r.get("start_url", "")
            actions_count = r.get("total_actions", len(r.get("actions", [])))
            tags = ", ".join(r.get("tags", []))

            # Format original manual duration vs automated execution duration and last run timestamp
            rec_ms = r.get("duration_ms", 0)
            rec_sec = rec_ms / 1000.0
            if rec_sec >= 60:
                rec_str = f"⏱ {int(rec_sec // 60)}m {int(rec_sec % 60)}s"
            else:
                rec_str = f"⏱ {rec_sec:.1f}s"

            last_exec = r.get("last_execution")
            if last_exec:
                auto_ms = last_exec.get("auto_duration_ms", 0)
                auto_sec = auto_ms / 1000.0
                factor = last_exec.get("speedup_factor", 1.0)
                last_time_str = last_exec.get("formatted_date", format_datetime_de(last_exec.get("timestamp")))
                if auto_sec >= 60:
                    auto_str = f"{int(auto_sec // 60)}m {int(auto_sec % 60)}s"
                else:
                    auto_str = f"{auto_sec:.1f}s"
                
                timing_display = f"{rec_str}  ➔  ⚡ {auto_str} ({factor}x)\n[Zuletzt am {last_time_str}]"
            else:
                timing_display = f"{rec_str} (Manuell)\n[Noch nicht ausgeführt]"

            chk = QCheckBox()
            chk_widget = QWidget()
            chk_layout = QHBoxLayout(chk_widget)
            chk_layout.addWidget(chk)
            chk_layout.setAlignment(Qt.AlignCenter)
            chk_layout.setContentsMargins(0,0,0,0)
            self.routines_table.setCellWidget(idx, 0, chk_widget)

            self.routines_table.setItem(idx, 1, QTableWidgetItem(name))
            
            date_item = QTableWidgetItem(date_str)
            date_item.setTextAlignment(Qt.AlignCenter)
            date_item.setForeground(Qt.GlobalColor.darkGray)
            self.routines_table.setItem(idx, 2, date_item)

            self.routines_table.setItem(idx, 3, QTableWidgetItem(url))
            self.routines_table.setItem(idx, 4, QTableWidgetItem(f"{actions_count} Aktionen"))

            timing_item = QTableWidgetItem(timing_display)
            timing_item.setTextAlignment(Qt.AlignCenter)
            if last_exec:
                timing_item.setForeground(Qt.GlobalColor.green)
            self.routines_table.setItem(idx, 5, timing_item)

            self.routines_table.setItem(idx, 6, QTableWidgetItem(tags))

            btn_widget = QWidget()
            btn_layout = QHBoxLayout(btn_widget)
            btn_layout.setContentsMargins(4, 2, 4, 2)
            btn_layout.setSpacing(6)

            run_btn = QPushButton("▶ Ausführen")
            run_btn.setMinimumWidth(95)
            run_btn.clicked.connect(lambda _, rname=name: self._run_single_routine(rname))
            btn_layout.addWidget(run_btn)

            edit_steps_btn = QPushButton("✏ Schritte")
            edit_steps_btn.setToolTip("Aktionsschritte dieser Routine bearbeiten, löschen & beschreiben")
            edit_steps_btn.setStyleSheet("background-color: #f9e2af; color: #11111b; padding: 4px 8px; font-weight: bold;")
            edit_steps_btn.setMinimumWidth(85)
            edit_steps_btn.clicked.connect(lambda _, rname=name: self._open_routine_editor(rname))
            btn_layout.addWidget(edit_steps_btn)

            report_btn = QPushButton("📊 Bericht")
            report_btn.setStyleSheet("background-color: #89b4fa; color: #11111b; padding: 4px 8px; font-weight: bold;")
            report_btn.setMinimumWidth(85)
            report_btn.clicked.connect(self._open_test_report)
            btn_layout.addWidget(report_btn)

            del_btn = QPushButton("🗑")
            del_btn.setObjectName("DangerButton")
            del_btn.setStyleSheet("background-color: #f38ba8; color: #11111b; padding: 4px 10px; font-weight: bold;")
            del_btn.clicked.connect(lambda _, rname=name: self._delete_routine(rname))
            btn_layout.addWidget(del_btn)

            self.routines_table.setCellWidget(idx, 7, btn_widget)

    def _refresh_groups_table(self):
        groups = self.manager.list_groups()
        self.groups_table.setRowCount(len(groups))

        for idx, g in enumerate(groups):
            gname = g.get("group_name", "")
            rcount = g.get("routine_count", len(g.get("routine_names", [])))
            rlist = ", ".join(g.get("routine_names", []))
            cdate = format_datetime_de(g.get("created_at", ""))

            chk = QCheckBox()
            chk_widget = QWidget()
            chk_layout = QHBoxLayout(chk_widget)
            chk_layout.addWidget(chk)
            chk_layout.setAlignment(Qt.AlignCenter)
            chk_layout.setContentsMargins(0,0,0,0)
            self.groups_table.setCellWidget(idx, 0, chk_widget)

            self.groups_table.setItem(idx, 1, QTableWidgetItem(gname))
            self.groups_table.setItem(idx, 2, QTableWidgetItem(f"{rcount} Routinen"))
            self.groups_table.setItem(idx, 3, QTableWidgetItem(rlist))

            cdate_item = QTableWidgetItem(cdate)
            cdate_item.setTextAlignment(Qt.AlignCenter)
            cdate_item.setForeground(Qt.GlobalColor.darkGray)
            self.groups_table.setItem(idx, 4, cdate_item)

            btn_widget = QWidget()
            btn_layout = QHBoxLayout(btn_widget)
            btn_layout.setContentsMargins(4, 2, 4, 2)
            btn_layout.setSpacing(6)

            run_btn = QPushButton("▶ Gruppe ausführen")
            run_btn.setMinimumWidth(140)
            run_btn.clicked.connect(lambda _, grp=g: self._run_group(grp))
            btn_layout.addWidget(run_btn)

            edit_btn = QPushButton("✏ Bearbeiten")
            edit_btn.setMinimumWidth(100)
            edit_btn.clicked.connect(lambda _, gname=gname: self._edit_group(gname))
            btn_layout.addWidget(edit_btn)

            report_btn = QPushButton("📊 Bericht")
            report_btn.setStyleSheet("background-color: #89b4fa; color: #11111b; padding: 4px 8px; font-weight: bold;")
            report_btn.setMinimumWidth(85)
            report_btn.clicked.connect(self._open_test_report)
            btn_layout.addWidget(report_btn)

            del_btn = QPushButton("🗑")
            del_btn.setObjectName("DangerButton")
            del_btn.setStyleSheet("background-color: #f38ba8; color: #11111b; padding: 4px 10px; font-weight: bold;")
            del_btn.clicked.connect(lambda _, gname=gname: self._delete_group(gname))
            btn_layout.addWidget(del_btn)

            self.groups_table.setCellWidget(idx, 5, btn_widget)

    def _refresh_suites_table(self):
        suites = self.manager.list_suites()
        self.suites_table.setRowCount(len(suites))

        for idx, s in enumerate(suites):
            sname = s.get("suite_name", "")
            icount = s.get("total_items", len(s.get("items", [])))
            desc = s.get("description", "")
            cdate = format_datetime_de(s.get("created_at", ""))

            chk = QCheckBox()
            chk_widget = QWidget()
            chk_layout = QHBoxLayout(chk_widget)
            chk_layout.addWidget(chk)
            chk_layout.setAlignment(Qt.AlignCenter)
            chk_layout.setContentsMargins(0,0,0,0)
            self.suites_table.setCellWidget(idx, 0, chk_widget)

            self.suites_table.setItem(idx, 1, QTableWidgetItem(sname))
            self.suites_table.setItem(idx, 2, QTableWidgetItem(f"{icount} Elemente"))
            self.suites_table.setItem(idx, 3, QTableWidgetItem(desc))

            cdate_item = QTableWidgetItem(cdate)
            cdate_item.setTextAlignment(Qt.AlignCenter)
            cdate_item.setForeground(Qt.GlobalColor.darkGray)
            self.suites_table.setItem(idx, 4, cdate_item)

            btn_widget = QWidget()
            btn_layout = QHBoxLayout(btn_widget)
            btn_layout.setContentsMargins(4, 2, 4, 2)
            btn_layout.setSpacing(6)

            run_btn = QPushButton("▶ Suite ausführen")
            run_btn.setMinimumWidth(130)
            run_btn.clicked.connect(lambda _, ste=s: self._run_suite(ste))
            btn_layout.addWidget(run_btn)

            edit_btn = QPushButton("✏ Bearbeiten")
            edit_btn.setMinimumWidth(100)
            edit_btn.clicked.connect(lambda _, sname=sname: self._edit_suite(sname))
            btn_layout.addWidget(edit_btn)

            report_btn = QPushButton("📊 Bericht")
            report_btn.setStyleSheet("background-color: #89b4fa; color: #11111b; padding: 4px 8px; font-weight: bold;")
            report_btn.setMinimumWidth(85)
            report_btn.clicked.connect(self._open_test_report)
            btn_layout.addWidget(report_btn)

            del_btn = QPushButton("🗑")
            del_btn.setObjectName("DangerButton")
            del_btn.setStyleSheet("background-color: #f38ba8; color: #11111b; padding: 4px 10px; font-weight: bold;")
            del_btn.clicked.connect(lambda _, sname=sname: self._delete_suite(sname))
            btn_layout.addWidget(del_btn)

            self.suites_table.setCellWidget(idx, 5, btn_widget)

    # -------------------------------------------------------------------------
    # FILTER & UI ACTIONS
    # -------------------------------------------------------------------------

    def _on_filter_changed(self):
        self._refresh_routines_table()

    def _on_speed_mode_changed(self, index: int):
        mode_code = self.speed_mode_combo.currentData() or "NORMAL"
        is_slowmo = (mode_code == "SLOWMO")
        self.slowmo_label.setVisible(is_slowmo)
        self.slowmo_slider.setVisible(is_slowmo)

    def _on_slider_value_changed(self, value: int):
        self.slowmo_label.setText(f"Verzögerung: {value}ms")
        if self.execution_thread and self.execution_thread.isRunning():
            self.execution_thread.update_slowmo(value)

    def _toggle_log_console(self):
        is_vis = self.log_console.isVisible()
        self.log_console.setVisible(not is_vis)
        self.toggle_log_btn.setText("Echtzeit-Log ausblenden ▲" if not is_vis else "Echtzeit-Log anzeigen ▼")

    # -------------------------------------------------------------------------
    # WIZARDS & DIALOGS
    # -------------------------------------------------------------------------

    def _open_new_routine_wizard(self):
        wizard = RoutineWizardDialog(self, manager=self.manager)
        wizard.wizard_completed_signal.connect(lambda _: self.refresh_all_views())
        wizard.exec()

    def _open_routine_editor(self, routine_name: str):
        dialog = RoutineEditorDialog(routine_name=routine_name, parent=self, manager=self.manager)
        dialog.routine_updated_signal.connect(lambda _: self.refresh_all_views())
        dialog.exec()

    def _open_new_group_dialog(self):
        dialog = GroupDialog(self, manager=self.manager)
        dialog.group_saved_signal.connect(lambda _: self.refresh_all_views())
        dialog.exec()

    def _open_new_suite_dialog(self):
        dialog = SuiteDialog(self, manager=self.manager)
        dialog.suite_saved_signal.connect(lambda _: self.refresh_all_views())
        dialog.exec()

    def _edit_group(self, group_name: str):
        grp = self.manager.get_group(group_name)
        if grp:
            dialog = GroupDialog(self, manager=self.manager, group_to_edit=grp)
            dialog.group_saved_signal.connect(lambda _: self.refresh_all_views())
            dialog.exec()

    def _edit_suite(self, suite_name: str):
        ste = self.manager.get_suite(suite_name)
        if ste:
            dialog = SuiteDialog(self, manager=self.manager, suite_to_edit=ste)
            dialog.suite_saved_signal.connect(lambda _: self.refresh_all_views())
            dialog.exec()

    def _delete_routine(self, routine_name: str):
        reply = QMessageBox.question(
            self,
            "Bestätigung",
            f"Möchten Sie die Routine '{routine_name}' wirklich löschen?",
            QMessageBox.Yes | QMessageBox.No
        )
        if reply == QMessageBox.Yes:
            self.manager.delete_routine(routine_name)
            self.refresh_all_views()

    def _delete_selected_routines(self):
        selected_names = self._get_checked_routine_names()
        if not selected_names:
            QMessageBox.warning(self, "Keine Auswahl", "Bitte wählen Sie in der Tabelle mindestens eine Routine aus.")
            return

        names_list_str = "\n".join([f"• {n}" for n in selected_names])
        reply = QMessageBox.question(
            self,
            "Mehrere Routinen löschen",
            f"Möchten Sie die folgenden {len(selected_names)} ausgewählten Routinen wirklich unwiderruflich löschen?\n\n{names_list_str}",
            QMessageBox.Yes | QMessageBox.No
        )
        if reply == QMessageBox.Yes:
            for rname in selected_names:
                self.manager.delete_routine(rname)
            self.refresh_all_views()

    def _delete_group(self, group_name: str):
        reply = QMessageBox.question(
            self,
            "Bestätigung",
            f"Möchten Sie die Gruppe '{group_name}' wirklich löschen?",
            QMessageBox.Yes | QMessageBox.No
        )
        if reply == QMessageBox.Yes:
            self.manager.delete_group(group_name)
            self.refresh_all_views()

    def _delete_selected_groups(self):
        selected_groups = self._get_checked_group_names()
        if not selected_groups:
            QMessageBox.warning(self, "Keine Auswahl", "Bitte wählen Sie in der Gruppen-Tabelle mindestens eine Gruppe aus.")
            return

        names_list_str = "\n".join([f"• {g}" for g in selected_groups])
        reply = QMessageBox.question(
            self,
            "Mehrere Gruppen löschen",
            f"Möchten Sie die folgenden {len(selected_groups)} ausgewählten Gruppen wirklich unwiderruflich löschen?\n\n{names_list_str}",
            QMessageBox.Yes | QMessageBox.No
        )
        if reply == QMessageBox.Yes:
            for gname in selected_groups:
                self.manager.delete_group(gname)
            self.refresh_all_views()

    def _delete_suite(self, suite_name: str):
        reply = QMessageBox.question(
            self,
            "Bestätigung",
            f"Möchten Sie die Suite '{suite_name}' wirklich löschen?",
            QMessageBox.Yes | QMessageBox.No
        )
        if reply == QMessageBox.Yes:
            self.manager.delete_suite(suite_name)
            self.refresh_all_views()

    def _delete_selected_suites(self):
        selected_suites = self._get_checked_suite_names()
        if not selected_suites:
            QMessageBox.warning(self, "Keine Auswahl", "Bitte wählen Sie in der Suiten-Tabelle mindestens eine Suite aus.")
            return

        names_list_str = "\n".join([f"• {s}" for s in selected_suites])
        reply = QMessageBox.question(
            self,
            "Mehrere Suiten löschen",
            f"Möchten Sie die folgenden {len(selected_suites)} ausgewählten Gesamt-Tests (Suiten) wirklich unwiderruflich löschen?\n\n{names_list_str}",
            QMessageBox.Yes | QMessageBox.No
        )
        if reply == QMessageBox.Yes:
            for sname in selected_suites:
                self.manager.delete_suite(sname)
            self.refresh_all_views()

    def _create_group_from_selection(self):
        selected_names = self._get_checked_routine_names()
        if not selected_names:
            QMessageBox.warning(self, "Keine Auswahl", "Bitte wählen Sie in der Tabelle mindestens eine Routine aus.")
            return

        dialog = GroupDialog(self, manager=self.manager)
        for rname in selected_names:
            dialog.selected_list.addItem(QListWidgetItem(rname))
        dialog.group_saved_signal.connect(lambda _: self.refresh_all_views())
        dialog.exec()

    def _get_checked_routine_names(self) -> List[str]:
        names = []
        for idx in range(self.routines_table.rowCount()):
            widget = self.routines_table.cellWidget(idx, 0)
            if widget:
                chk = widget.findChild(QCheckBox)
                if chk and chk.isChecked():
                    names.append(self.routines_table.item(idx, 1).text())
        return names

    def _get_checked_group_names(self) -> List[str]:
        names = []
        for idx in range(self.groups_table.rowCount()):
            widget = self.groups_table.cellWidget(idx, 0)
            if widget:
                chk = widget.findChild(QCheckBox)
                if chk and chk.isChecked():
                    names.append(self.groups_table.item(idx, 1).text())
        return names

    def _get_checked_suite_names(self) -> List[str]:
        names = []
        for idx in range(self.suites_table.rowCount()):
            widget = self.suites_table.cellWidget(idx, 0)
            if widget:
                chk = widget.findChild(QCheckBox)
                if chk and chk.isChecked():
                    names.append(self.suites_table.item(idx, 1).text())
        return names

    # -------------------------------------------------------------------------
    # TEST EXECUTION ENGINE INTEGRATION
    # -------------------------------------------------------------------------

    def _get_execution_files_for_routines(self, routine_names: List[str]) -> List[str]:
        files = []
        for rname in routine_names:
            robot_file = Path(f"tests/test_{rname}.robot").resolve()
            if not robot_file.exists():
                json_file = Path(f"routines/{rname}.json").resolve()
                if json_file.exists():
                    res = self.converter.convert_json_to_resource_and_test(json_file)
                    robot_file = Path(res["test_path"])

            if robot_file.exists():
                files.append(str(robot_file))
        return files

    def _run_single_routine(self, routine_name: str):
        files = self._get_execution_files_for_routines([routine_name])
        self._start_execution_for_files(files)

    def _run_selected_routines(self):
        names = self._get_checked_routine_names()
        if not names:
            QMessageBox.warning(self, "Keine Auswahl", "Bitte wählen Sie in der Tabelle mindestens eine Routine aus.")
            return
        files = self._get_execution_files_for_routines(names)
        self._start_execution_for_files(files)

    def _run_selected_groups(self):
        gnames = self._get_checked_group_names()
        if not gnames:
            QMessageBox.warning(self, "Keine Auswahl", "Bitte wählen Sie in der Gruppen-Tabelle mindestens eine Gruppe aus.")
            return

        routine_names = []
        for gname in gnames:
            grp = self.manager.get_group(gname)
            if grp:
                routine_names.extend(grp.get("routine_names", []))

        files = self._get_execution_files_for_routines(routine_names)
        self._start_execution_for_files(files)

    def _run_selected_suites(self):
        snames = self._get_checked_suite_names()
        if not snames:
            QMessageBox.warning(self, "Keine Auswahl", "Bitte wählen Sie in der Suiten-Tabelle mindestens eine Suite aus.")
            return

        routine_names = []
        for sname in snames:
            ste = self.manager.get_suite(sname)
            if ste:
                for item in ste.get("items", []):
                    itype = item.get("type")
                    iname = item.get("name")
                    if itype == "routine":
                        routine_names.append(iname)
                    elif itype == "group":
                        grp = self.manager.get_group(iname)
                        if grp:
                            routine_names.extend(grp.get("routine_names", []))

        files = self._get_execution_files_for_routines(routine_names)
        self._start_execution_for_files(files)

    def _run_group(self, group: dict):
        rnames = group.get("routine_names", [])
        files = self._get_execution_files_for_routines(rnames)
        self._start_execution_for_files(files)

    def _run_suite(self, suite: dict):
        routine_names = []
        for item in suite.get("items", []):
            itype = item.get("type")
            iname = item.get("name")
            if itype == "routine":
                routine_names.append(iname)
            elif itype == "group":
                grp = self.manager.get_group(iname)
                if grp:
                    routine_names.extend(grp.get("routine_names", []))

        files = self._get_execution_files_for_routines(routine_names)
        self._start_execution_for_files(files)

    def _start_test_execution(self):
        curr_tab = self.tabs.currentIndex()
        if curr_tab == 0:
            self._run_selected_routines()
        elif curr_tab == 1:
            checked_groups = self._get_checked_group_names()
            if checked_groups:
                self._run_selected_groups()
            else:
                curr_row = self.groups_table.currentRow()
                if curr_row >= 0:
                    gname = self.groups_table.item(curr_row, 1).text()
                    grp = self.manager.get_group(gname)
                    if grp:
                        self._run_group(grp)
                else:
                    QMessageBox.warning(self, "Keine Auswahl", "Bitte wählen Sie eine Gruppe in der Tabelle aus.")
        elif curr_tab == 2:
            checked_suites = self._get_checked_suite_names()
            if checked_suites:
                self._run_selected_suites()
            else:
                curr_row = self.suites_table.currentRow()
                if curr_row >= 0:
                    sname = self.suites_table.item(curr_row, 1).text()
                    ste = self.manager.get_suite(sname)
                    if ste:
                        self._run_suite(ste)
                else:
                    QMessageBox.warning(self, "Keine Auswahl", "Bitte wählen Sie eine Suite in der Tabelle aus.")

    def _start_execution_for_files(self, file_paths: List[str]):
        if not file_paths:
            QMessageBox.warning(self, "Keine Testdateien", "Keine gültigen Test-Suites zum Ausführen gefunden.")
            return

        headless = self.headless_cb.isChecked()
        speed_code = self.speed_mode_combo.currentData() or "NORMAL"
        slowmo_val = self.slowmo_slider.value() if speed_code == "SLOWMO" else 500
        is_manual = (speed_code == "MANUAL")

        self.run_btn.setEnabled(False)
        self.stop_btn.setEnabled(True)
        self.next_step_btn.setEnabled(is_manual)
        self.log_console.clear()
        self.log_console.setVisible(True)
        self.toggle_log_btn.setText("Echtzeit-Log ausblenden ▲")

        self.execution_thread = ExecutionControllerThread(
            test_file_paths=file_paths,
            headless=headless,
            speed_mode=speed_code,
            slowmo_ms=slowmo_val
        )
        self.execution_thread.log_signal.connect(self._append_log)
        self.execution_thread.progress_signal.connect(self._on_progress_update)
        self.execution_thread.step_waiting_signal.connect(self._on_step_waiting)
        self.execution_thread.finished_signal.connect(self._on_execution_finished)
        self.execution_thread.start()

    @Slot(str)
    def _append_log(self, text: str):
        if not text:
            return
        if "<" in text and ">" in text:
            self.log_console.appendHtml(text)
        else:
            self.log_console.appendPlainText(text)
        self.log_console.moveCursor(QTextCursor.End)

    @Slot(int, str)
    def _on_progress_update(self, step: int, keyword: str):
        self.status_label.setText(f"Status: Führe Schritt {step} aus — '{keyword}'")
        self.status_label.setStyleSheet("color: #89b4fa; font-weight: bold;")

    @Slot(int, str)
    def _on_step_waiting(self, step: int, keyword: str):
        self.status_label.setText(f"Status: PAUSIERT bei Schritt {step} ('{keyword}') — Bitte 'Nächster Schritt' klicken!")
        self.status_label.setStyleSheet("color: #f9e2af; font-weight: bold;")
        self.next_step_btn.setEnabled(True)

    def _trigger_next_step(self):
        if self.execution_thread and self.execution_thread.isRunning():
            self.status_label.setText("Status: Nächster Schritt wird ausgeführt...")
            self.execution_thread.trigger_next_step()

    def _stop_execution(self):
        if self.execution_thread and self.execution_thread.isRunning():
            self.execution_thread.terminate()
            self.status_label.setText("Status: Ausführung vom Benutzer abgebrochen.")
            self.status_label.setStyleSheet("color: #f38ba8; font-weight: bold;")
            self.run_btn.setEnabled(True)
            self.stop_btn.setEnabled(False)
            self.next_step_btn.setEnabled(False)

    @Slot(bool, str)
    def _on_execution_finished(self, success: bool, summary: str):
        self.run_btn.setEnabled(True)
        self.stop_btn.setEnabled(False)
        self.next_step_btn.setEnabled(False)

        # Refresh all views so the new timing benchmark results update in tables
        self.refresh_all_views()

        if success:
            self.status_label.setText("Status: Testausführung ERFOLGREICH beendet! (Klicken Sie auf '📊 Testbericht öffnen', um Ergebnisse anzuzeigen)")
            self.status_label.setStyleSheet("color: #a6e3a1; font-weight: bold;")
        else:
            self.status_label.setText("Status: Testausführung FEHLGESCHLAGEN. (Klicken Sie auf '📊 Testbericht öffnen' für Details)")
            self.status_label.setStyleSheet("color: #f38ba8; font-weight: bold;")
