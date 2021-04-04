#!/bin/bash
HIST_FILE="$HOME/.cache/sway-launcher-desktop-history.txt"
NEW_FILE="$HOME/.cache/sway-launcher-desktop-history.new"
DEL=$'\34'
if [[ -f ${HIST_FILE} ]]; then
    touch $NEW_FILE
    while read line; do
        FILEPATH=$(echo $line | cut -d ' ' -f 2 | cut -d ${DEL} -f 1)
        TYPE=$(echo $line | cut -d ${DEL} -f 2)
        if [ $TYPE = "desktop" ]; then
            if [ -f ${FILEPATH} ]; then
                echo "${line}" >> $NEW_FILE
            fi
        elif [ $TYPE = "command" ]; then
            if  hash ${FILEPATH} ; then
                echo "${line}" >> $NEW_FILE
            fi
        fi
    done < ${HIST_FILE}
    mv $NEW_FILE $HIST_FILE
fi
