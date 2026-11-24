# Stellar AI Telemetry

Lokale Telemetrie-Mod fuer die technische Pruefung unter Stellaris 4.5.2.

## Verhalten

- Laeuft einmal pro Spielmonat fuer das menschlich gespielte Land.
- Schreibt Zusammenfassung, Ressourcen und Forschungsoutput als `AI_*`-Zeilen nach `logs/game.log`.
- Enthält keine Konsolenbefehle, keine Command-Queue, keine Save- oder Dateizugriffe und keine Eingaben.
- Veraendert keine Spielwerte. Fuer die Logausgabe werden nur mod-eigene, numerische Exportvariablen gesetzt.

## Testablauf

1. Im Stellaris-Launcher nur in einem separaten Test-Playset aktivieren.
2. Einen Non-Ironman-Testsave laden oder ein neues Testspiel beginnen.
3. Einen Monatswechsel abwarten und einen neuen Save erzeugen.
4. In `logs/game.log` nach `AI_SUMMARY|` und `AI_STATE_END|` suchen.
5. Sichtbare Spielwerte mit dem letzten Export vergleichen.

Diese Mod nicht zusammen mit einer anderen AI/MCP-Bridge aktivieren, damit Logzeilen nicht vermischt werden.
