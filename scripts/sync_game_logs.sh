#!/bin/bash

date=`date +"%Y-%m-%d_%T"`

source="$HOME/.local/share/Paradox Interactive/Stellaris"
target="../sync/log_files"
declare -a LOGTYPES=('logs' 'exceptions' 'crashes')

function println() {
    if [[ -n $1 ]]; then
        echo -e "\n${1}\n"
    fi
}

println "Syncing last Stellaris(TM) game logs ..."

for LOGTYPE in "${LOGTYPES[@]}"; do
  tmp="${source}/${LOGTYPE}"
  println "Syncing Stellaris(TM) game ${LOGTYPE} ..."
  rsync -av "${tmp}" "${target}"
done

println "${date/_/ } - Stellaris(TM) game data synced"
