# Bestandsaufnahme - 15. Oktober 2026

## Rechner und Werkzeuge

| Bereich | Befund |
| --- | --- |
| Betriebssystem-Sitzung | Linux, X11 |
| Arbeitsspeicher | 31 GiB gesamt, 24 GiB zum Zeitpunkt der Pruefung verfuegbar |
| GPU | AMD Radeon RX 580, 4 GiB VRAM |
| Node.js | v24.19.0 |
| npm | v11.17.0 |
| Codex CLI | v0.160.1 |
| Ollama | v0.40.4 vorhanden; `qwen3.5:9b` wurde anschliessend heruntergeladen |

## Stellaris

| Bereich | Pfad oder Befund |
| --- | --- |
| Installation | `~/.steam/steam/steamapps/common/Stellaris` |
| Benutzerdaten | `~/.local/share/Paradox Interactive/Stellaris` |
| Installierte Version | Cygnus v4.5.2 (9776), Steam-Build 25664273 |
| Letzter untersuchter Log | 24. September 2026, Cygnus v4.5.1 |
| MCP-Logexport | Kein `AI_`-Prefix in `logs/game.log`; Bridge war nicht aktiv |

## Mod- und Logbefunde

Die Kernmods Eldritch Abyss, Stellar Kernel, Stellar Empires, Memento Vivere sowie A Link To The Galaxy und Galaxy Of Power deklarieren 4.5-Unterstuetzung. Galaxy Spawner deklariert 4.4; Shadow of the Nether, Mysteries of the Mists, Helices of Life und Sum of Parts deklarieren 4.3.

Der letzte `error.log` enthaelt unter anderem fehlende Lokalisierungen fuer den Eldritch-Abyss-Rift-Bypass, doppelte Event-IDs, ungueltige Scope-Wechsel sowie fehlende GUI-Typen. Diese Fehler sind vor einer dynamischen MCP-Auswertung zu klassifizieren und Mod-Ursachen zuzuordnen.

## MCP-Kandidat

Der lesende Fork unter `stellaris-mcp-readonly/` basiert auf Commit `13de108638fc52ac37837e5785789ff28f7b82d6` vom 20. Maerz 2026. Der urspruengliche Staging-Clone wurde nach der Integration entfernt; das Upstream-README dokumentierte Stellaris 4.3.1.

Sein `scripts/install-mod.sh` verwendet `~/Documents/Paradox Interactive/Stellaris`, das auf diesem System nicht der verwendete Benutzerdatenpfad ist. Der Installer wurde nicht ausgefuehrt.

Der zuvor abgebrochene Befehl `npm ci && npm run build` wurde im geklonten `.tmp`-Projekt dennoch vollstaendig abgeschlossen: `node_modules` und `dist` sind vorhanden. Es wurden keine MCP-Eintraege, keine Stellaris-Mod und keine Spieldateien angelegt oder veraendert.
