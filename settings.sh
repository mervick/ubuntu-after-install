#!/bin/bash

echo ""
echo "################################"
echo "### Configure settings #########"
echo "################################"

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