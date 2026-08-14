# Web UI Test-Automation Framework (`py-web-tester`)

Ein modulares, hochflexibles und skalierbares Test-Framework für automatisierte Webanwendungs-Tests aus der **Nutzerperspektive**.

Baut auf **Robot Framework**, der modernen **Browser Library (Playwright)** und **Python** auf.

---

## 📁 Ordnerstruktur

```text
py-web-tester/
├── run_tests.py                # Python CLI Test Runner & Routine Recorder Entrypoint
├── record_routine.py           # Eigenständiges CLI-Skript für den interaktiven Routine-Recorder
├── main.py                     # Interaktives Konsolenmenü & Haupt-Einstiegspunkt
├── pyproject.toml              # UV / Python Projekt-Abhängigkeiten
│
├── routines/                   # Aufgezeichnete JSON-Interaktionsspuren (Traces)
│   └── <routine_name>.json
│
├── variables/                  # Konfigurationen & Umgebungsdaten
│   └── env_config.py           # URLs, Timeouts, Browser-Optionen, Credentials
│
├── libraries/                  # Eigene Python-Klassen (Recorder, Converter & Custom Keywords)
│   ├── routine_recorder.py     # Interaktiver Browser Recorder mit HUD-Overlay
│   ├── routine_converter.py    # Konvertiert JSON-Traces in Robot Resource Blöcke
│   ├── routine_executor.py     # Replay-Logik für aufgezeichnete Routinen
│   ├── custom_actions.py       # Fachliche Logik, Datenberechnung, Validierungen
│   └── web_helpers.py          # Hilfsfunktionen (Dateien, JSON, API-Checks)
│
├── resources/                  # Wiederverwendbare Keywords & Page Objects
│   ├── common.resource         # Globales Setup/Teardown, Browser-Start
│   └── page_objects/           # Entwurfsmuster "Page Object Model" (POM)
│       ├── login_page.resource # Selektoren & Aktionen für Login-Ansichten
│       └── todo_page.resource  # Selektoren & Aktionen für Task/Todo-Interaktionen
│
├── tests/                      # Ausführbare Test-Suiten & generierte Routine-Tests
│   ├── 01_smoke_tests.robot    # Schnellchecks & Integrationstests
│   ├── 02_todo_e2e_tests.robot # Interaktionstests & Workflows
│   ├── 03_login_tests.robot    # Authentifizierungstests
│   └── test_<routine>.robot    # Generierte Routine-Tests
│
└── results/                    # Generierte Testberichte (HTML-Log & Screenshots)
```

---

## 🔴 Interaktive Testroutinen-Aufzeichnung (Test Block Recorder)

Mit dem **Test Block Recorder** können Sie neue Testroutinen interaktiv im Browser aufzeichnen:

1. Führen Sie Aktionen im Browser durch (Mausklicks mit genauen relativen und absoluten Koordinaten, Texteingaben, Tastatur-Shortcuts, Scrollen, Formularinteraktionen).
2. Der Recorder erfasst automatisch alle Event-Spuren, exakte Millisekunden-Zeitstempel und die vollständige DOM-/Seitenstruktur.
3. Nach Klick auf **STOP RECORDING** (oder `Ctrl+Shift+S`) wird die Interaktionskette abgespeichert und automatisch in einen **wiederverwendbaren Robot Framework Testblock** (`resources/page_objects/<name>.resource`) sowie einen **ausführbaren Test** (`tests/test_<name>.robot`) konvertiert!

### Aufzeichnung starten

#### Option A: Interaktives Konsolen-Menü
```bash
python main.py
# Wählen Sie Option 2, um eine neue Routine aufzuzeichnen
```

#### Option B: Über `record_routine.py`
```bash
python record_routine.py --url https://example.com --name login_flow
```

#### Option C: Über `run_tests.py`
```bash
python run_tests.py --record --record-url https://example.com --record-name checkout_routine
```

---

## 🚀 Schnellstart & Testausführung

### 1. Abhängigkeiten installieren & Browser initialisieren (einmalig)
```bash
uv sync
uv run rfbrowser init
```

### 2. Tests ausführen

#### Variante A: Über den Python-Runner
```bash
# Alle Tests ausführen
python run_tests.py

# Nur Smoke-Tests ausführen
python run_tests.py --tag smoke

# Aufgezeichneten Routine-Test ausführen
python run_tests.py --suite tests/test_smoke_demo_routine.robot

# Im sichtbaren Browser-Modus (Headed) testen
python run_tests.py --headed
```

#### Variante B: Direkt über Robot Framework CLI
```bash
python -m robot --pythonpath . --outputdir results tests/
```

### 3. Berichte ansehen
Nach der Testausführung finden Sie die detaillierten Testberichte unter:
- `results/report.html` (Zusammenfassung & Status)
- `results/log.html` (Detail-Protokoll aller Schritte & Fehlerscreenshots)

---

## 🛠️ Erweiterungsanleitung: Neue Features & Regeln hinzufügen

### 1. Aufgezeichnete Blöcke in bestehende Tests einbauen
In `resources/page_objects/<routine_name>.resource` stehen Ihnen die aufgezeichneten Keywords zur Verfügung (z. B. `Execute Routine Login Flow`). Importieren Sie das Resource-File in Ihrer Test-Suite:

```robot
*** Settings ***
Resource    ../resources/page_objects/login_flow.resource

*** Test Cases ***
Mein Komplett-Test
    Execute Routine Login Flow
```

### 2. Neues Page Object manuell anlegen (`resources/page_objects/`)
1. Erstellen Sie eine Datei `resources/page_objects/settings_page.resource`.
2. Definieren Sie Selektoren im `*** Variables ***`-Block.
3. Schreiben Sie Keywords im `*** Keywords ***`-Block.

### 3. Neue Python-Aktion/Regel hinzufügen (`libraries/`)
1. Öffnen Sie `libraries/custom_actions.py`.
2. Erstellen Sie eine Methode mit `@keyword("Mein Keyword Name")`.
3. Nutzen Sie das Keyword direkt in allen `.robot`-Dateien!