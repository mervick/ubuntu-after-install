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


## User settings ##
# standart scrollbar
gsettings set com.canonical.desktop.interface scrollbar-mode normal
# datetime format
gsettings set com.canonical.indicator.datetime custom-time-format "'%a, %e %b %H:%M'"
gsettings set com.canonical.indicator.datetime time-format custom
# disable commercial services
gsettings set com.canonical.Unity.Lenses disabled-scopes "['more_suggestions-amazon.scope', 'more_suggestions-u1ms.scope', 'more_suggestions-populartracks.scope', 'music-musicstore.scope', 'more_suggestions-ebay.scope', 'more_suggestions-ubuntushop.scope', 'more_suggestions-skimlinks.scope']"
# fix auto-detect windows-1251 encoding in gedit
gsettings set org.gnome.gedit.preferences.encodings auto-detected "['UTF-8', 'WINDOWS-1251', 'CURRENT', 'ISO-8859-15', 'UTF-16']"
# remove online-linses from dash
wget -q -O - https://fixubuntu.com/fixubuntu.sh | bash


## Global settings ##
# swappiness
sudo bash -c 'echo "vm.swappiness = 10" >> /etc/sysctl.conf'
# disable bug alerts
sudo sed -i "s/enabled=1/enabled=0/g" '/etc/default/apport'
# show system services in autoload manager
sudo sed -i 's/NoDisplay=true/NoDisplay=false/g' /etc/xdg/autostart/*.desktop
# hide system services in autoload manager
#sudo sed -i 's/NoDisplay=false/NoDisplay=true/g' /etc/xdg/autostart/*.desktop


## Gui ##
# add padding at gtk menus
sudo bash -c 'echo "
GtkTreeMenu.menu,
.toolbar .primary-toolbar .menu,
.toolbar .menubar.toolbar .menu,
.toolbar .header-bar .menu,
GtkMenuToolButton.menu,
.primary-toolbar .button .menu,
.menubar.toolbar .button .menu,
.header-bar .button .menu,
.menu {
    padding: 5px 0 5px 0;
}
" >> /usr/share/themes/Ambiance/gtk-3.0/gtk-widgets.css'



