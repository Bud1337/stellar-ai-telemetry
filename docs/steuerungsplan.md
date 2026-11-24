# Steuerungsplan fuer Stellaris-Testaktionen

## Ziel

Stellaris-Modtests sollen mit einem Baseline-Save reproduzierbar vorbereitet, ausgefuehrt und ausgewertet werden. Telemetrie bleibt der Nachweis des Spielzustands; Steuerung wird getrennt aufgebaut.

## Verantwortlichkeiten

| Baustein | Aufgabe |
| --- | --- |
| Telemetrie-Mod | Monatsdaten und klar benannte Test-Events im Spiel. |
| MCP | Liest Telemetrie und Saves, erstellt eine pruefbare Command-Queue und protokolliert Testaktionen. |
| Konsolen-Ausfuehrer | Fuehrt freigegebene Queue-Eintraege im Testspiel aus. Zunaechst manuell, spaeter optional per UI-Runner. |
| Test-Skill | Waehlt Baseline und Aktion, prueft Sollwerte und dokumentiert das Ergebnis. |

## Phasen

1. Einen Queue-Vertrag mit `test_id`, Baseline, erlaubter Aktions-ID, Konsolenbefehl, Sollsignal und Status definieren.
2. Einen harmlosen End-to-End-Test bauen: Konsolen-Event erzeugt `AI_TEST_ACTION`, der Monats-Pulse bleibt vollstaendig.
3. Kleine Mod-Testaktionen fuer Events, Flags, Modifier und Krisen-Voraussetzungen hinzufuegen.
4. Den MCP um `list_test_actions`, `queue_test_action`, `get_test_queue`, `record_test_execution` und `verify_test_result` erweitern.
5. Einen Projekt-Skill aus dem bewiesenen manuellen Ablauf ableiten.
6. Einen UI-Runner erst bewerten, wenn die manuelle Queue zuverlaessig funktioniert.

## Grenzen

- Baseline ist `TelemetryTest.sav`; produktive Saves und Playsets bleiben aussen vor.
- Stellaris-Mods koennen keine externe Queue-Datei selbst einlesen. Die Konsolenausfuehrung ist daher eine eigene Stufe.
- Zuerst sind nur erlaubte Aktions-IDs vorgesehen. Ein Rohbefehl-Kanal wird erst nach erfolgreichen Testreihen bewertet.

## Start nach der Pause

1. Queue-Vertrag und erste diagnostische Aktions-ID festlegen.
2. Test-Event in der Mod implementieren.
3. MCP-Queue-Tools gegen das Fixture testen.
4. Manuellen Konsolen-Durchlauf mit `TelemetryTest` machen.
5. Den Test-Skill erstellen.
