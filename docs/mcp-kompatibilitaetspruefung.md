# MCP-Kompatibilitätsprüfung - statischer erster Durchgang

## Urteil

Der MCP-Kandidat ist **nicht freigegeben für eine Host-Installation oder eine direkte Codex-MCP-Konfiguration**. Ein späterer, strikt lesender Test in einem Container ist plausibel, sobald die untenstehenden Punkte behandelt oder bewusst begrenzt sind.

Die Prüfung war statisch: Quellcode und PDXScript des geklonten Commit `13de108638fc52ac37837e5785789ff28f7b82d6` wurden mit der lokal installierten Stellaris-Version 4.5.2 verglichen. Es gab keinen Spielstart, keinen Zugriff auf Saves durch das Programm und keine Installation der Companion-Mod.

## Kompatible Grundlagen

| Bereich | Befund |
| --- | --- |
| `on_game_start_country` | In Stellaris 4.5.2 vorhanden |
| `on_monthly_pulse_country` | In Stellaris 4.5.2 vorhanden |
| `export_trigger_value_to_variable` | In Vanilla-4.5.2-Skripten verwendet |
| `export_resource_stockpile_to_variable` | In Vanilla-4.5.2-Skripten verwendet |
| `export_resource_income_to_variable` | In Vanilla-4.5.2-Skripten verwendet |
| Logprinzip | Technisch plausibel: Companion-Mod schreibt `AI_*` nach `game.log`; der Server liest es |

Die Versionsangabe `supported_version="4.3.*"` ist trotzdem eine reale Sperre: Sie kann im Launcher als Inkompatibilitaet angezeigt werden und ersetzt keinen Laufzeittest gegen 4.5.2.

## Nachgewiesene Probleme

### P1 - Der Logparser vertauschte Kennzahlen der Zusammenfassung - korrigiert im isolierten Checkout

Die Companion-Mod schreibt die Zusammenfassung in dieser Reihenfolge:

`Datum | Name | Planeten | Pops | verwendete Flottenkapazitaet | maximale Flottenkapazitaet | Flottenstaerke`

Der Logparser liest dagegen Feld 4 als maximale Kapazitaet und Feld 5 als Flottenstaerke. Dadurch wird die verwendete Kapazitaet als maximale Kapazitaet ausgegeben, die maximale Kapazitaet als Flottenstaerke und die echte Flottenstaerke verworfen.

Die Feldzuordnung wurde nur im isolierten Checkout korrigiert. Der Parser bewahrt nun auch die verwendete Flottenkapazitaet und den Forschungsoutput. Er bereinigt ausserdem alte, fehlerhaft mit Backslashes geschriebene Platzhalterwerte.

### P1 - Lese- und Schreibrechte sind im gleichen Server vereint

Neben Lesetools registriert der Server `execute_command`, `execute_effect` und `queue_commands`. Diese erzeugen `ai_commands.txt` im konfigurierten Stellaris-Benutzerdatenordner.

Folge: Ein Modell oder Client mit Zugriff auf den Server kann Schreibtools entdecken und aufrufen. Der erste Test braucht daher entweder einen Build ohne diese Tools oder eine Sandbox, deren Dokumentenpfad auf einen leeren temporaeren Ordner zeigt. Ein echter Stellaris-Benutzerdatenordner darf nicht eingebunden werden.

### P2 - Falsche Linux-Standardpfade

Konfiguration und Parser-Testskript erwarten `~/Documents/Paradox Interactive/Stellaris`; vorhanden ist hier `~/.local/share/Paradox Interactive/Stellaris`. Der Server kann dies zwar mit `STELLARIS_DOCUMENTS_PATH` uebersteuern, `npm run test:parser` beachtet die Variable jedoch nicht.

Folge: Der Parser-Test ist auf diesem Rechner ohne Anpassung nicht nutzbar. Die Host-Pfade duerfen nicht als schnelle Loesung in die globale Codex-Konfiguration geschrieben werden.

### P2 - Versions- und Installer-Drift

Das bereitgestellte Installationsskript schreibt ebenfalls nach `~/Documents/...` und erzeugt einen Descriptor fuer `4.3.*`. Es ist fuer diese Umgebung nicht ausfuehrbar.

### P2 - Unvollstaendige Logdaten

`AI_TECH_OUTPUT` wird vom Parser erkannt, aber verworfen. Das Log liefert auch keine vollstaendige Diplomatieauswertung fuer die Tools. Der Save-Parser ist fuer umfassendere Informationen vorgesehen, muss jedoch zuerst gegen eine 4.5.2-Testsave-Kopie getestet werden.

## Build-Status

Der isolierte Checkout besitzt eine erstellte `dist/`-Ausgabe; die JavaScript-Syntaxpruefung von `dist/index.js` war erfolgreich. Dieser Befund belegt nur den Node/TypeScript-Build, nicht die Funktion mit einem 4.5.2-Spielstand.

## Nächste Prüfungen

1. Read-only-Variante des Servers planen: Schreibtools ausschließen oder auf einen leeren Temp-Pfad begrenzen.
2. Eine Kopie eines einzelnen Test-Saves als schreibgeschütztes Container-Volume vorbereiten.
3. Parser-Ausgabe mit in Stellaris sichtbaren Werten vergleichen.
4. Erst danach die Companion-Mod als eigene, versionsangepasste Testmod bewerten.
5. Nach dem ersten Monatswechsel `AI_*`-Logausgabe prüfen und die bekannten Parserfehler gegen den tatsächlichen Export abgleichen.

## Bereitgestellte Telemetrie-Mod

Die Quelle liegt unter `src/` und heisst **Stellar AI Telemetry**. Der bisherige Laufzeittest erfolgte noch mit der vorherigen, separat installierten Probe `stellar-ai-telemetry-probe-4.5.2`; die umbenannte Quelle wurde noch nicht ausgerollt.

Die Telemetrie-Mod hat keinen Bezug zum MCP-Server und keine Command-Queue. Sie registriert nur einen monatlichen Country-Pulse fuer das menschliche Land und schreibt `AI_SUMMARY`, `AI_RESOURCES`, `AI_TECH_OUTPUT` sowie `AI_STATE_END` nach `game.log`.

### Laufzeittest - bestanden

Die vorherige Probe wurde in einem separaten Test-Playset mit Stellaris 4.5.2 gestartet. Beim Monatswechsel am `2200.02.01` schrieb sie einen vollständigen Block nach `game.log`:

- `AI_SUMMARY` fuer die Vereinigten Koenigreiche von Eternia: 1 Planet, 3500 Pops, 15/75 Flottenkapazitaet, 188.08594 Flottenstaerke.
- Sieben `AI_RESOURCES`-Zeilen mit Lagerbestand und monatlichem Einkommen.
- `AI_TECH_OUTPUT` mit 22.08937 Physik sowie jeweils 17.58937 Gesellschafts- und Ingenieurforschung.
- `AI_STATE_END` als vollstaendiger Abschlussmarker.

Es gab keine Telemetrie-spezifische Scriptfehlermeldung. Der erste Lauf zeigte jedoch einen fuehrenden Backslash vor Datum und Reichsname; Ursache waren unnoetige Backslashes vor den Stellaris-Platzhaltern. Die zwei betreffenden Testmod-Dateien wurden fuer den naechsten Spielstart korrigiert. Die Korrektur wirkt nicht rueckwirkend auf den bereits laufenden Prozess.

### Parser-Lesetest - bestanden

Der korrigierte Parser las denselben, bereits vorhandenen `game.log`-Block ohne Schreibzugriff erfolgreich ein. Das Ergebnis war `2200.02.01`, 1 Planet, 3500 Pops, 15/75 Flottenkapazitaet, 188.08594 Flottenstaerke sowie die sieben exportierten Ressourcen und die drei Forschungswerte. Damit ist der Telemetriepfad Mod -> `game.log` -> Parser unter 4.5.2 nachgewiesen.

### Save-Parser-Test - teilweise bestanden

Der Testsave `ai_telemetry_2200_02-16.sav` wurde in eine bitgleiche Kopie unter `test-data/` uebernommen und nur diese Kopie gelesen. Der Parser kann den 4.5.2-Save oeffnen und liefert korrekte Metadaten (`Cygnus v4.5.2`, Datum `2200.02.21`), Lagerbestaende, einen Planeten, 47 bekannte Laender, keine Kriege und die abgeschlossenen Technologien.

Die Untersuchung des echten Save-Schemas zeigt drei Anpassungspunkte fuer eine spaetere Parser-Erweiterung:

- Die monatliche Bilanz liegt in `budget.current_month.balance` nach Quellen verschachtelt; die bisherige direkte Abfrage liefert deshalb Einkommen als null.
- Aktive Forschung liegt in `tech_status.physics_queue`, `society_queue` und `engineering_queue`, nicht in `active_research`.
- Die Flottenliste besteht in `fleets_manager.owned_fleets` aus Objekten wie `{ fleet = ID }`, nicht aus direkten IDs. Die maximale Flottenkapazitaet ist nicht mehr im erwarteten Feld `navy_cap` gespeichert.

Die Logtelemetrie liefert fuer diese Felder bereits korrekte Momentaufnahmen. Der Saveparser bleibt deshalb vorerst ein ergaenzender Datenkanal, nicht die alleinige Quelle fuer aktuelle Wirtschaft, Forschung oder Flottenwerte.

## Read-only MCP - erstellt und verifiziert

Der lokale Fork `stellaris-mcp-readonly` bildet die naechste Stufe. Er entfernt die drei Schreibtools `execute_command`, `execute_effect` und `queue_commands` sowie den Quellcode des Command Writers. Der Server startet ohne gesetzte Umgebungsvariablen nur mit einem lokalen Test-Fixture und faellt nicht auf einen echten Stellaris-Pfad zurueck.

Ein MCP-Stdio-Test mit dem Test-Fixture hat den Server initialisiert, `tools/list` abgefragt und `get_game_state` aus dem Log-Snapshot aufgerufen. Sichtbar waren genau acht Lese-Tools; der Aufruf lieferte den erwarteten Zustand vom 2200.02.01. Es besteht noch keine Codex-MCP-Konfiguration und keine Verbindung zum echten Stellaris-Benutzerdatenordner.
