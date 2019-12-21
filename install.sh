#!/bin/bash

echo "Building  and installing i3 preset for user $USER into $HOME"
printf "Continue? (y/n): "
read con
if [ "$con" != "y" ] && [ "$con" != "Y" ]; then
	echo "Exiting..." && exit
fi
sleep 3


echo "Setting up apt and installing important packages..."
sleep 1

### Add i386 arch
sudo dpkg --add-architecture i386

sudo apt update && sudo apt upgrade -y

### Install important packages first
sudo apt install -y curl wget apt-transport-https dirmngr rsync

### copying sources.list
sudo rsync -a -v etc/apt/sources.list /etc/apt/

sudo apt update && sudo apt upgrade -y


echo "Installing packages..."
sleep 1

### installing packages and default applications
sudo apt install -y autoconf suckless-tools xorg software-properties-common cmake fonts-font-awesome fonts-roboto devscripts snapd file-roller pcmanfm pulseaudio pavucontrol alsa-utils numix-gtk-theme screenfetch feh build-essential gtk2-engines-murrine gtk2-engines vim ranger caca-utils highlight atool w3m poppler-utils mediainfo compton python-pip python3-pip libcanberra-gtk-module firefox-esr libgtk2.0-dev libgtk-3-dev gnome-devel dolphin imagemagick scrot nnn tig arandr htop mesa-utils mesa-utils-extra emacs xsel bluez-cups blueman gpick tree ninja-build gettext libtool-bin g++ unzip firmware-linux-nonfree firmware-iwlwifi jq firmware-realtek nmap zeal thunderbird ack libfile-next-perl neofetch

### creating dirs like "Pictures", "Downloads" etc.
xdg-user-dirs-update

### creating dirs
mkdir $HOME/.config/
mkdir $HOME/.themes/
mkdir $HOME/.fonts/
mkdir $HOME/.icons
mkdir $HOME/GitRepos/


echo "Installing paper icons..."
sleep 1

### paper icons
cd /tmp/
wget https://launchpadlibrarian.net/425392562/paper-icon-theme_1.5.723-201905252133~daily~ubuntu18.04.1_all.deb
sudo dpkg -i paper*.deb
sudo apt install -f -y


echo "Copying theme, wallpapers, fonts and starti3 script..."
sleep 1

cd $SCRIPTPATH
### copying theme
rsync -a -v .themes/oomox-BrightNight $HOME/.themes/

### wallpaper
sudo rsync -a -v wallpapers/ /usr/share/wallpapers/
rsync -a -v wallpapers $HOME/

### fonts
rsync -a -v .fonts $HOME/
fc-cache

### starti3 script
sudo rsync -a -v usr/local/bin/ /usr/local/bin/

### infinality font rendering (osx option)
#sudo dpkg -i infinality/libfreetype-infinality6_2.4.9-3_amd64.deb infinality/freetype-infinality_2.4.9-3_all.deb infinality/fontconfig-infinality_1-2_all.deb
#sudo bash /etc/fonts/infinality/infctl.sh setstyle osx

### Instal fish shell
chmod +x installations/install_fish.sh
bash installations/install_fish.sh

### Custom applications installer (mostly github stuff)
chmod +x installations/install_applications.sh
bash installations/install_applications.sh

### gaps installer
chmod +x installations/install_i3.sh
bash installations/install_i3.sh

cd $SCRIPTPATH
### copying configs
rsync -a -v .gtkrc-2.0 $HOME/
rsync -a -v .xinitrc $HOME/
rsync -a -v .config/ $HOME/.config/

### Git env
git config --global user.email "Felixs.Developer@gmail.com"
git config --global user.name "FancyChaos"

### Fix broken packages for good measure (why not?)
sudo apt install -f -y

### Boot into command line
sudo systemctl set-default multi-user.target

echo "Installation done..."
sleep 1

### Reboot if second arguement is not empty
if [ ! -z "$REBOOT" ]
then
	sudo reboot
fi

echo "Please reboot your system"