#!/bin/bash


type="default"
if test $# -gt 0; then
    type="$1"
fi


echo ""
echo "################################"
echo "### Update & Upgrade ###########"
echo "################################"

echo "sudo apt-get update"
sudo apt-get update
echo "sudo apt-get upgrade -y"
sudo apt-get upgrade -y



echo ""
echo "################################"
echo "### Install packages ###########"
echo "################################"

while read line; do
    if test "${#line}" -gt 0; then
        if test "${line:0:1}" != "#"; then
            echo "sudo apt-get install -y ${line}"
            sudo apt-get install -y "${line}"
        fi
    fi
done < "${type}/packages.txt"



echo ""
echo "################################"
echo "### Auto clear #################"
echo "################################"

echo "sudo apt-get autoremove"
sudo apt-get autoremove
echo "sudo apt-get autoclean"
sudo apt-get autoclean
echo "sudo apt-get clean"
sudo apt-get clean

