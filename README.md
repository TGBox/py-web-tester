projekt_verzeichnis/
├── tests/                  # Die eigentlichen Testfälle
│   ├── login_tests.robot
│   └── kalender_tests.robot
├── resources/              # Wiederverwendbare Keywords und UI-Locator
│   ├── page_objects/       # Keywords getrennt nach Ansichten (z.B. kalender_page.resource)
│   └── common.resource     # Übergreifende Setup-Keywords (z.B. Browser Start)
├── libraries/              # Eigener Python-Code
│   └── db_helper.py        # Python-Skripte (z.B. für Datenbank-Testdaten)
├── variables/              # Umgebungsdaten (Test, Stage, Prod)
│   └── test_env.py         # URLs, Usernamen und Passwörter
└── results/                # Generierte Reports (von Git ignorieren!)