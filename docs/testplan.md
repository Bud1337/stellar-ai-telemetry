# Testplan

## Ziel

Reproduzierbare Mod-QA mit lokaler KI vorbereiten. Die KI darf zuerst nur vorhandene Daten lesen und auswerten.

## Phasen

1. **Kompatibilitaet bewerten**
   - MCP-Quellcode, PDXScript und Installationsannahmen gegen Stellaris 4.5.2 pruefen.
   - Keine Companion-Mod installieren.
   - Ergebnis: Freigabe, konkreter Patch-Plan oder Ablehnung.
   - Erster Durchgang: PDXScript-Grundlagen sind vorhanden; Logparser, Pfade und Tool-Rechte blockieren noch einen Host-Test.

2. **Mod-Fehler inventarisieren**
   - `error.log` in Startblocker, Funktionsfehler und harmlose Warnungen einordnen.
   - Fehler dem verantwortlichen Mod, einer Fremdmod oder Vanilla zuordnen.

3. **Testumgebung definieren**
   - Eigenes Launcher-Playset.
   - Eigener Non-Ironman-Testsave; keine produktiven Saves.
   - Dokumentierte Versionen, Checksumme und aktivierte Mods.

4. **Lesetest vorbereiten**
   - Testsave als Kopie bereitstellen.
   - Save-Profile auflisten sowie Spielstand und Log lesen.
   - Ergebnisse gegen sichtbare Spielwerte pruefen.

5. **Dynamische Mod-QA planen**
   - Je Testfall: Ausgangssave, Vorbedingung, Aktion, Sollzustand, Istzustand, Logbeleg und Reproduktion.
   - Zuerst Events, Technologien, Gebaeude, Modifier und `on_actions` mit begrenzten Szenarien.

6. **Command-Queue erst spaeter bewerten**
   - Nur nach erfolgreichem Lesetest und einer separaten Freigabe.
   - Jeder Befehl wird vor Ausfuehrung als Textdatei kontrolliert.
   - `run ai_commands.txt` bleibt ein manueller Spielschritt.

## Abnahmekriterien fuer Phase 1

- Alle verwendeten Pfade sind fuer Linux korrekt.
- Die Versionabweichung 4.3.1 zu 4.5.2 ist fachlich bewertet.
- Der Build laeuft isoliert und ohne Zugriff auf Spiel- oder Codex-Dateien.
- Die Companion-Mod wird erst nach Pruefung ihrer PDXScript-Kompatibilitaet betrachtet.
