# Web UI Test-Automation Framework (`py-web-tester`)

Ein modulares, hochflexibles und skalierbares Test-Framework für automatisierte Webanwendungs-Tests aus der **Nutzerperspektive**.

Baut auf **Robot Framework**, der modernen **Browser Library (Playwright)** und **Python** auf.

---

## 📁 Ordnerstruktur

```text
py-web-tester/
├── run_tests.py                # Python CLI Test Runner
├── main.py                     # Einstiegspunkt zum Ausführen der Tests
├── pyproject.toml              # UV / Python Projekt-Abhängigkeiten
│
├── variables/                  # Konfigurationen & Umgebungsdaten
│   └── env_config.py           # URLs, Timeouts, Browser-Optionen, Credentials
│
├── libraries/                  # Eigene Python-Klassen (Custom Keywords & Logik)
│   ├── custom_actions.py       # Fachliche Logik, Datenberechnung, Validierungen
│   └── web_helpers.py          # Hilfsfunktionen (Dateien, JSON, API-Checks)
│
├── resources/                  # Wiederverwendbare Keywords & Page Objects
│   ├── common.resource         # Globales Setup/Teardown, Browser-Start
│   └── page_objects/           # Entwurfsmuster "Page Object Model" (POM)
│       ├── login_page.resource # Selektoren & Aktionen für Login-Ansichten
│       └── todo_page.resource  # Selektoren & Aktionen für Task/Todo-Interaktionen
│
├── tests/                      # Ausführbare Test-Suiten (Bhaiovior/User Perspective)
│   ├── 01_smoke_tests.robot    # Schnellchecks & Integrationstests
│   ├── 02_todo_e2e_tests.robot # Interaktionstests & Workflows
│   └── 03_login_tests.robot    # Authentifizierungstests
│
└── results/                    # Generierte Testberichte (HTML-Log & Screenshots)
```

---

## 🚀 Schnellstart & Testausführung

### 1. Abhängigkeiten installieren & Browser initialisieren (einmalig)
```bash
uv sync
uv run rfbrowser init
```

### 2. Tests ausführen

#### Variante A: Über den komfortablen Python-Runner
```bash
# Alle Tests ausführen
uv run python run_tests.py

# Nur Smoke-Tests ausführen
uv run python run_tests.py --tag smoke

# Im sichtbaren Browser-Modus (Headed) testen
uv run python run_tests.py --headed

# Mit spezifischer Browser-Engine testen (chromium, firefox, webkit)
uv run python run_tests.py --browser firefox
```

#### Variante B: Direkt über Robot Framework CLI
```bash
uv run robot --pythonpath . --outputdir results tests/
```

### 3. Berichte ansehen
Nach der Testausführung finden Sie die detaillierten Testberichte unter:
- `results/report.html` (Zusammenfassung & Status)
- `results/log.html` (Detail-Protokoll aller Schritte & Fehlerscreenshots)

---

## 🛠️ Erweiterungsanleitung: Neue Features & Regeln hinzufügen

Das Framework ist darauf ausgelegt, mit minimalem Aufwand erweitert zu werden:

### 1. Neues Page Object anlegen (`resources/page_objects/`)
Wenn ein neues Feature / eine neue Seite hinzugefügt wird (z. B. Einstellungen):
1. Erstellen Sie eine Datei `resources/page_objects/settings_page.resource`.
2. Definieren Sie Selektoren im `*** Variables ***`-Block.
3. Schreiben Sie benutzerlesbare Keywords im `*** Keywords ***`-Block.

### 2. Neue Python-Aktion/Regel hinzufügen (`libraries/`)
Für komplexe Business-Logik, Prüfregeln oder Testdatengenerierung:
1. Öffnen Sie `libraries/custom_actions.py` (oder erstellen Sie eine neue Python-Datei).
2. Erstellen Sie eine Methode mit dem Decorator `@keyword("Mein Keyword Name")`.
3. Nutzen Sie das Keyword direkt in allen `.robot`-Dateien!

### 3. Neue Test-Suite anlegen (`tests/`)
1. Erstellen Sie eine neue `.robot`-Datei in `tests/` (z. B. `04_settings_tests.robot`).
2. Importieren Sie `common.resource` sowie die benötigten Page Objects.
3. Formulieren Sie Testfälle aus der Perspektive des Endanwenders.