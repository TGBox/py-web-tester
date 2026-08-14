# Web UI Test-Automation Framework (`py-web-tester`)

Ein modulares, hochflexibles und skalierbares Test-Framework für automatisierte Webanwendungs-Tests aus der **Nutzerperspektive**.

Baut auf **PySide6 (Qt Desktop GUI)**, **Robot Framework**, der modernen **Browser Library (Playwright)** und **Python** auf.

---

## 🖥️ Graphical User Interface (PySide6 GUI)

Das Framework verfügt über eine moderne, interaktive PySide6 Desktop-Benutzeroberfläche:

### GUI starten
```bash
python app.py
# ODER
python main.py  # Option 1 wählen
```

### Key Features der GUI
1. **4-Schritt Routine-Wizard ("Neue Routine definieren")**:
   - **Metadaten-Eingabe**: Routine-Name, Webseiten-URL, Beschreibung und beliebig viele Tags.
   - **Interaktive Browser-Aufnahme**: Öffnet Chromium mit HUD-Overlay und Verlust-freier CDP-Event-Erfassung.
   - **Vorschau & Prüfung**: Tabelle aller erfassten Aktionen, Aktionen-Anzahl und Dauer.
   - **Speichern & Konvertieren**: Speichert JSON-Trace inkl. Erstellungsdatum (`recorded_at`) und generiert automatisch Robot Framework `.resource` und `.robot` Dateipaare.
2. **3-Tab Hauptansicht**:
   - **Einzelne Routinen**: Scrollbare Kartenansicht mit Suchfeld, Tag-Filter, kleinem Erstellungsdatum badge (`DD.MM.YYYY HH:MM`), Aktionen-Anzahl, Dauer und Mehrfachauswahl.
   - **Routinen-Gruppen**: Beliebige Subroutinen zu wiederverwendbaren Gruppen zusammenstellen (`groups/<name>.json`).
   - **Gesamt-Tests / Suiten**: Master-Testsuiten aus Gruppen und Einzelroutinen orchestrieren (`suites/<name>.json`).
3. **Ausführungssteuerung & Modi**:
   - **Headless / Headed Modus**: Per Umschalter konfigurierbar.
   - **Geschwindigkeit & Stepping**:
     - *Normal*: Maximale Geschwindigkeit.
     - *Slow-Mo Slider*: Stufenlos einstellbare Verzögerung (100 ms – 2000 ms zwischen Schritten).
     - *Manuell (Schritt-für-Schritt)*: Die Testausführung pausiert vor jedem Schritt. Über den Knopf **"Nächster Schritt"** schalten Sie Aktion für Aktion frei.
   - **Echtzeit-Log**: Ausklappbares Konsolenfenster für Live-Testprotokolle.

---

## 📁 Ordnerstruktur

```text
py-web-tester/
├── app.py                      # Einstiegspunkt für die PySide6 Desktop GUI
├── main.py                     # Interaktives Konsolenmenü & Haupt-Einstiegspunkt
├── run_tests.py                # Python CLI Test Runner & Routine Recorder Entrypoint
├── record_routine.py           # Eigenständiges CLI-Skript für den Routine-Recorder
├── pyproject.toml              # UV / Python Projekt-Abhängigkeiten (Robot, Playwright, PySide6)
│
├── gui/                        # PySide6 GUI Paket & Benutzeroberfläche
│   ├── main_window.py          # Tab-basierte Hauptansicht mit Tag-Filter & Steuerung
│   ├── routine_wizard.py       # 4-Schritt Modal-Wizard für neue Routinen
│   ├── group_dialog.py         # Dialog für Subroutinen-Gruppen
│   ├── suite_dialog.py         # Dialog für Gesamt-Tests (Master Test Suites)
│   ├── execution_controller.py # Asynchroner QThread Test-Execution Engine
│   └── theme.py                # QSS Dunkelmodus-Design
│
├── routines/                   # Aufgezeichnete JSON-Interaktionsspuren (Traces)
├── groups/                     # Gespeicherte Routinen-Gruppen
├── suites/                     # Gespeicherte Master-Testsuiten
│
├── libraries/                  # Eigene Python-Klassen (Recorder, Converter & Listeners)
│   ├── routine_manager.py      # Metadaten-Verwaltung, Gruppen, Suiten & Tag-Filterung
│   ├── step_listener.py        # Robot Listener für Slow-Mo & Schritt-für-Schritt Stepping
│   ├── routine_recorder.py     # Interaktiver Browser Recorder mit HUD-Overlay & CDP Stream
│   ├── routine_converter.py    # Konvertiert JSON-Traces in Robot Resource Blöcke
│   ├── routine_executor.py     # Replay-Logik für aufgezeichnete Routinen
│   └── custom_actions.py       # Fachliche Logik, Datenberechnung, Validierungen
│
├── resources/                  # Wiederverwendbare Keywords & Page Objects
│   ├── common.resource         # Globales Setup/Teardown, Browser-Start
│   └── page_objects/           # Entwurfsmuster "Page Object Model" (POM)
│
├── tests/                      # Ausführbare Test-Suiten & generierte Routine-Tests
└── results/                    # Generierte Testberichte (HTML-Log & Screenshots)
```

---

## 🔴 Interaktive Testroutinen-Aufzeichnung (Test Block Recorder)

Mit dem **Test Block Recorder** können Sie neue Testroutinen interaktiv im Browser aufzeichnen:

1. Führen Sie Aktionen im Browser durch (Mausklicks mit genauen relativen und absoluten Koordinaten, Texteingaben, Tastatur-Shortcuts, Scrollen, Formularinteraktionen).
2. Der Recorder erfasst automatisch alle Event-Spuren, exakte Millisekunden-Zeitstempel und die vollständige DOM-/Seitenstruktur.
3. Nach Klick auf **STOP RECORDING** (oder `Ctrl+Shift+S`) wird die Interaktionskette abgespeichert und automatisch in einen **wiederverwendbaren Robot Framework Testblock** (`resources/page_objects/<name>.resource`) sowie einen **ausführbaren Test** (`tests/test_<name>.robot`) konvertiert!

---

## 🚀 Schnellstart & Testausführung

### 1. Abhängigkeiten installieren & Browser initialisieren (einmalig)
```bash
uv sync
uv run rfbrowser init
```

### 2. GUI oder CLI starten

#### Variante A: Graphical User Interface (GUI)
```bash
python app.py
```

#### Variante B: Über Konsolenmenü
```bash
python main.py
```

#### Variante C: Direkt über CLI Test Runner
```bash
# Alle Tests ausführen
python run_tests.py

# Nur bestimmten Tag ausführen
python run_tests.py --tag smoke

# Im sichtbaren Browser-Modus (Headed) testen
python run_tests.py --headed
```

### 3. Berichte ansehen
Nach der Testausführung finden Sie die detaillierten Testberichte unter:
- `results/report.html` (Zusammenfassung & Status)
- `results/log.html` (Detail-Protokoll aller Schritte & Fehlerscreenshots)