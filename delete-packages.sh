#!/bin/bash


type="default"
if test $# -gt 0; then
    type="$1"
fi


echo ""
echo "################################"
echo "### Delete unused packages #####"
echo "################################"

while read line; do
    if test "${#line}" -gt 0; then
        if test "${line:0:1}" != "#"; then
            echo "sudo apt-get purge ${line}"
            sudo apt-get purge "${line}"
        fi
    fi
done < "${type}/delete-packages.txt"
