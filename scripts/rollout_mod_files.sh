#!/bin/bash

MODNAME="stellar-ai-telemetry";
DATE=`date +"%Y-%m-%d_%T"`
CURRENT=$(pwd)
DIRECTORY="$HOME/.local/share/Paradox Interactive/Stellaris/mod"

RSYNC_DRYRUN=""
RSYNC_DRYRUN_MSG=""

ENABLE_PORTRAIT_SELECTION="no"
LAUNCH_STELLARIS="no"

function println() {
    if [[ -n $1 ]]; then
        echo -e "\n${1}\n"
    fi
}

pushd "$DIRECTORY" > /dev/null

while getopts "bpdl" OPTION
do
    case $OPTION in
        b)
            println "Backup current mod data..."
            tar -czf "${CURRENT}/../backup/${MODNAME}_${DATE}".tar.gz "${MODNAME}" --checkpoint=.100
            ;;
        d)
            RSYNC_DRYRUN_MSG="using rsync dry run"
            RSYNC_DRYRUN="n"
            ;;
        p)
            ENABLE_PORTRAIT_SELECTION="yes"
            ;;
        l)
            LAUNCH_STELLARIS="yes"
            ;;
    esac
done

popd > /dev/null

println "Enable Portrait Selection (yes/no)? $ENABLE_PORTRAIT_SELECTION ..."

if [[ "$ENABLE_PORTRAIT_SELECTION" == "yes" ]]; then
  echo -e "BackUp Portrait Categories ..."

  if [[ ! -d "${CURRENT}/../backup/temp" ]]; then
    mkdir "${CURRENT}/../backup/temp"
  fi

  cp "${CURRENT}/../src/common/portrait_categories/eldritch_abyss_portrait_categories.txt" "${CURRENT}/../backup/temp"

  echo -e  "Enable Portrait Selection ..."

  i=1
  while line='' read -r a; do
    if [[ "$i" -gt 2 ]]; then
     echo "${a//#/ }"
    fi
    i="$i"+1
  done < "${CURRENT}/../src/common/portrait_categories/eldritch_abyss_portrait_categories.txt" > eldritch_abyss_portrait_categories.txt

  mv eldritch_abyss_portrait_categories.txt ../src/common/portrait_categories/
fi

println "Sync new mod data ${RSYNC_DRYRUN_MSG}..."

rsync -"${RSYNC_DRYRUN}"av ../src/ "${DIRECTORY}/${MODNAME}"/ --delete || println "rsync not executed. check folders and whether rsync is installed or not"

if [[ "$ENABLE_PORTRAIT_SELECTION" == "yes" ]]; then
  echo -e "\nRestoring Portrait Categories ..."
  cp "${CURRENT}/../backup/temp/eldritch_abyss_portrait_categories.txt" "${CURRENT}/../src/common/portrait_categories"
fi

println "Create mod meta data ..."

cp "${DIRECTORY}/${MODNAME}/descriptor.mod" "${DIRECTORY}/${MODNAME}.mod"
echo "" >> "${DIRECTORY}/${MODNAME}.mod"
echo "path=\"${DIRECTORY}/${MODNAME}\"" >> "${DIRECTORY}/${MODNAME}.mod"

echo "${DATE/_/ }"

println "Launch Stellaris (yes/no)? $LAUNCH_STELLARIS ..."

if [[ "$LAUNCH_STELLARIS" == "yes" ]]; then
  steam steam://rungameid/281990 > /dev/null 2>&1 &
fi
