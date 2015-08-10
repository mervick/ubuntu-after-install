#!/bin/bash


echo ""
echo "################################"
echo "### Delete unused packages #####"
echo "################################"

while read line; do
    if test "${#line}" -gt 0; then
        if test "${line:0:1}" != "#"; then
            echo "sudo apt-get purge {$line}"
            sudo apt-get purge "{$line}"
        fi
    fi
done < delete-packages.txt



echo ""
echo "################################"
echo "### Add repositories ###########"
echo "################################"

while read line; do
    if test "${#line}" -gt 0; then
        if test "${line:0:1}" != "#"; then
            data=()
            while IFS='=' read -ra ADDR; do
                for i in "${ADDR[@]}"; do
                    data+=("$(echo -e "${i}" | sed -e 's/^[[:space:]]*//' | sed -e 's/[[:space:]]*$//')")
                done
            done <<< "$line"

            if test "${#data[@]}" -gt 1; then
                if test "${data[0]}" == "PPA"; then
                    echo "sudo add-apt-repository ppa:${data[1]}"
                    sudo add-apt-repository ppa:"${data[1]}"

                elif test "${data[0]}" == "REPO"; then
                    echo "sudo add-apt-repository ${data[1]}"
                    sudo add-apt-repository "${data[1]}"

                elif test "${data[0]}" == "KEY"; then
                    echo "wget -q -O - ${data[1]} | sudo apt-key add -"
                    wget -q -O - "${data[1]}" | sudo apt-key add -

                elif test "${data[0]}" == "SOURCE"; then
                    if test "${#data[@]}" -gt 2; then
                        echo "sudo sh -c \"echo \\\"${data[1]}\\\" >> \\\"/etc/apt/sources.list.d/${data[2]}.list\\\"\""
                        sudo sh -c "echo \"${data[1]}\" >> \"/etc/apt/sources.list.d/${data[2]}.list\""
                    fi
                fi
            fi
        fi
    fi
done < repositories.txt



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
            echo "sudo apt-get install -y {$line}"
            sudo apt-get install -y "{$line}"
        fi
    fi
done < packages.txt



echo ""
echo "################################"
echo "### Auto clear #################"
echo "################################"

echo "sudo apt-get autoremove"
sudo apt-get autoremove
echo "sudo apt-get autoclear"
sudo apt-get autoclear

