#!/bin/bash


type="default"
if test $# -gt 0; then
    type="$1"
fi



echo ""
echo "################################"
echo "### Add repositories ###########"
echo "################################"

while read line; do
    if test "${#line}" -gt 0; then
        if test "${line:0:1}" != "#"; then
            data=()
            RELEASE="$(lsb_release -sc)"
            while IFS='=' read -ra ADDR; do
                for i in "${ADDR[@]}"; do
                    data+=("$(echo -e "${i}" | sed -e 's/^[[:space:]]*//' | sed -e 's/[[:space:]]*$//' | sed -e 's/$RELEASE/'"${RELEASE}"'/g')")
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
done < "${type}/repositories.txt"
