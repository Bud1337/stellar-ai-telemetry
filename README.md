# Stellar AI Telemetry

Arbeitsbereich fuer nachvollziehbare Stellaris-Mod-QA mit lokaler KI.

Der Ordner buendelt die Telemetrie-Modquelle, den lesenden MCP-Fork, Testdaten und die Planung. Er enthaelt keine Verbindung zu einem echten Stellaris-Spielstand; Testdaten sind Kopien.

## Arbeitsstand

- Stellaris: Cygnus v4.5.2
- Telemetrie: erfolgreich in einem Testspiel ausgefuehrt
- MCP: lesender Fork, gegen einen lokalen Test-Snapshot validiert
- Automatische Spielsteuerung: nicht enthalten

## Dokumente

- [Bestandsaufnahme](docs/bestandsaufnahme-2026-10-15.md)
- [MCP-Kompatibilitätsprüfung](docs/mcp-kompatibilitaetspruefung.md)
- [Testplan](docs/testplan.md)
- [Steuerungsplan](docs/steuerungsplan.md)
- [Sandbox-Konzept](sandbox/README.md)
- [Read-only MCP](stellaris-mcp-readonly/README.md)

## Struktur

- `src/`: Quelle der Telemetrie-Mod
- `stellar-ai-telemetry.mod`: lokaler Descriptor fuer eine spaetere Installation
- `stellaris-mcp-readonly/`: lesender MCP-Fork mit Fixture
- `test-data/`: nicht versionierte Kopien von Testspielstaenden
- `scripts/`: künftige, explizit freigegebene Testhelfer

## Grenzen

Der MCP-Fork liest standardmaessig nur sein lokales Fixture. Konsolenbefehle und automatische Spielsteuerung sind nicht implementiert.
