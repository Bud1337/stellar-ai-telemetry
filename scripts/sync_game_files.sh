#!/bin/bash

DATE=`date +"%Y-%m-%d_%T"`
CURRENT=$(pwd)
DIRECTORY="$HOME/.steam/debian-installation/steamapps/common/Stellaris"
TARGET="../sync/files"
FILES=(
    "common/ascension_perks/00_ascension_perks.txt"
    "common/governments/civics/00_civics.txt"
    "common/policies/00_policies.txt"
    "common/scripted_effects/01_start_of_game_effects.txt"
    "common/scripted_triggers/00_scripted_triggers.txt"
    "common/scripted_triggers/01_scripted_triggers_planet_killers.txt"
    "common/tradition_categories/01_psionics.txt"
    "common/traits/04_species_traits.txt"
    "events/game_start.txt"
    "interface/game_setup/setup.gui"
)

function println() {
    if [[ -n $1 ]]; then
        echo -e "\n${1}\n"
    fi
}

println "Syncing Stellaris(TM) game data ..."

for FILE in "${FILES[@]}"
do
  println "Syncing file '${FILE}'"
  if [ ! -d "$TARGET/$(dirname ${FILE})" ]; then
    mkdir -p "$TARGET/$(dirname ${FILE})"
  fi

  # sync the file
	rsync -av --rsync-path="mkdir -p /path/to/directory && rsync" "${DIRECTORY}/${FILE}" "$TARGET/${FILE}"
done

println "${DATE/_/ } - Stellaris(TM) game data synced"
