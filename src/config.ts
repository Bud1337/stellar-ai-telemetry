import { join } from "path";

export interface StellarisMcpConfig {
  /** Path to a read-only Stellaris data snapshot. */
  stellarisDocumentsPath: string;
  /** Path to Stellaris installation */
  stellarisInstallPath: string;
  /** Path to game.log */
  gameLogPath: string;
  /** Path to save games directory */
  saveGamesPath: string;
  /** Path to the mod directory in documents */
  modDocumentsPath: string;
  /** Active save game profile name */
  saveProfile: string;
  /** How often (in game months) to do a full state dump */
  fullDumpInterval: number;
}

export function loadConfig(): StellarisMcpConfig {
  // Deliberately defaults to a local fixture instead of the user's game data.
  const documentsPath =
    process.env.STELLARIS_DOCUMENTS_PATH ||
    join(process.cwd(), "test-fixture", "documents");

  const installPath =
    process.env.STELLARIS_INSTALL_PATH ||
    "";

  const saveProfile = process.env.STELLARIS_SAVE_PROFILE || "";

  return {
    stellarisDocumentsPath: documentsPath,
    stellarisInstallPath: installPath,
    gameLogPath: join(documentsPath, "logs", "game.log"),
    saveGamesPath: join(documentsPath, "save games"),
    modDocumentsPath: join(documentsPath, "mod"),
    saveProfile,
    fullDumpInterval: 1,
  };
}
