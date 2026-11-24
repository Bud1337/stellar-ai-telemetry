# Sandbox-Konzept

## Schutzgrenze

Der MCP-Quellcode liegt als eigenstaendiger, lesender Fork unter `../stellaris-mcp-readonly`. Der Ordner ist keine Sicherheits-Sandbox; die Begrenzung entsteht durch die entfernten Schreibtools und das lokale Test-Fixture.

## Vorgesehene Ausfuehrungsumgebung

Fuer weitere Builds und Parser-Tests ist ein Container vorgesehen. Der Container erhaelt:

- ein eigenes Node-Image und einen eigenen Paketcache;
- den MCP-Checkout als Arbeitskopie;
- keine Einbindung von `~/.codex`, Steam oder dem Stellaris-Installationsverzeichnis;
- bei Lesetests nur eine explizit ausgewaehlte Save-Kopie und einen Log-Snapshot als schreibgeschuetzte Mounts.

## Regeln

- Abhaengigkeiten zunaechst mit `npm ci --ignore-scripts` installieren.
- Nach der Installation Build und Parser ohne Netzverbindung ausfuehren.
- Installer-Skripte niemals im Container oder auf dem Host ausfuehren, bevor deren Zielpfade und Schreiboperationen geprueft sind.
- Keine Host-Verzeichnisse schreiben lassen ausser einem dedizierten, temporaeren Ergebnisordner.
