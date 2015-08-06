#!/bin/bash


## Repositories ##
# multimedia & codecs
sudo add-apt-repository "deb http://download.videolan.org/pub/debian/stable/ /"
wget -O - http://download.videolan.org/pub/debian/videolan-apt.asc | sudo apt-key add -
# touchpad-indicator
sudo add-apt-repository ppa:atareao/atareao -y
# ubuntu-tweak
sudo add-apt-repository ppa:tualatrix/ppa -y
#sudo add-apt-repository ppa:tualatrix/next -y
# nemo icon
sudo add-apt-repository ppa:webupd8team/nemo -y
# themes
sudo add-apt-repository ppa:noobslab/themes -y
# caffeine
sudo add-apt-repository ppa:caffeine-developers/ppa -y
# power manager
sudo add-apt-repository ppa:linrunner/tlp -y
# weather indicator
sudo add-apt-repository ppa:atareao/atareao -y
# classic menu indicator
sudo add-apt-repository ppa:diesch/testing -y
# systemback
sudo add-apt-repository ppa:nemh/systemback -y
# Oracle Java
sudo add-apt-repository ppa:webupd8team/java -y
# Skype
sudo add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner" -y
# Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'


## Update & upgrade ##
sudo apt-get update
sudo apt-get upgrade -y


## Install packages ##
# multimedia & codecs
sudo apt-get install ubuntu-restricted-extras -y
sudo apt-get install libavcodec-extra -y
# touchpad-indicator
sudo apt-get install touchpad-indicator -y
# ubuntu-tweak
sudo apt-get install ubuntu-tweak -y
# unity-tweak-tool
sudo apt-get install unity-tweak-tool -y
# Skype
sudo apt-get install sni-qt:i386 libdbusmenu-qt2:i386 libqt4-dbus:i386 libxss1:i386 -y
sudo apt-get install libgtk2.0-0:i386 gtk2-engines:i386 libgconf-2-4:i386 -y
sudo apt-get install gtk2-engines-murrine:i386 -y
sudo apt-get install skype -y
# flash-pugin
sudo apt-get install flashplugin-nonfree -y
sudo apt-get install pepperflashplugin-nonfree  -y
# gimp
sudo apt-get install gimp -y
# compiz-config
sudo apt-get install compizconfig-settings-manager compiz-plugins-extra -y
# caffeine
sudo apt-get install caffeine -y
# dconf-tools
sudo apt-get install dconf-tools -y
# power manager
sudo apt-get install tlp tlp-rdw -y; sudo tlp start
# weather indicator
sudo apt-get install my-weather-indicator -y
# classic menu indicator
sudo apt-get install classicmenu-indicator -y
# systemback
sudo apt-get install systemback -y
# archivers
sudo apt-get install p7zip-rar p7zip-full unace unrar zip unzip sharutils rar uudeview mpack arj cabextract file-roller-y
# Audacious
sudo apt-get install audacious -y
# VLC Media Player
sudo apt-get install vlc -y
# Oracle Java
sudo apt-get install oracle-java8-installer -y
# Chrome
sudo apt-get install google-chrome-stable -y


## remove extra packages ##
# Orca Screen Reader
sudo apt-get purge gnome-orca
# Zeitgeist Datahub
sudo apt-get purge zeitgeist zeitgeist-core zeitgeist-datahub
# Deja dup
sudo apt-get purge deja-dup


# clear
sudo apt-get autoremove


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



