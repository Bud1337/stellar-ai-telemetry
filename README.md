# Stellaris MCP Read-Only

Lokaler, isolierter Read-only-Fork des Stellaris-MCP-Projekts fuer Mod-QA unter Stellaris 4.5.2.

## Sicherheitsgrenze

Der Fork registriert nur Lese-Tools:

- `get_game_state`
- `get_resources`
- `get_planets`
- `get_fleets`
- `get_technologies`
- `get_diplomacy`
- `list_save_profiles`
- `analyze_situation`

Es gibt weder `execute_command`, `execute_effect` noch `queue_commands`. Der zugehoerige Quellcode zum Schreiben von `ai_commands.txt` wurde entfernt.

Ohne `STELLARIS_DOCUMENTS_PATH` liest der Server nur aus `test-fixture/documents` innerhalb dieses Ordners. Er greift nie automatisch auf das Stellaris-Benutzerverzeichnis zu.

## Lokaler Test

`test-fixture/` ist ein nicht versionierter Snapshot mit einem Testsave und einem `game.log`-Ausschnitt. Er dient nur dem lokalen MCP-Protokolltest.

```bash
npm run build
STELLARIS_DOCUMENTS_PATH="$PWD/test-fixture/documents" \
STELLARIS_SAVE_PROFILE=testprofile \
node dist/index.js
```

Die Abhaengigkeiten werden nicht im Projekt installiert: `node_modules` ist ein lokaler Symlink auf den bereits isolierten Basis-Checkout unter `.tmp/`.

## Verifikation

Der Server wurde gegen das Test-Fixture ueber den MCP-Stdio-Handshake getestet. `tools/list` lieferte genau die acht Lese-Tools; `get_game_state` gab den aus Stellaris 4.5.2 exportierten Monatszustand vom 2200.02.01 korrekt aus.
