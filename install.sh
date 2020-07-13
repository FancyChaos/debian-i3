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
sudo apt install -y autoconf suckless-tools xorg software-properties-common cmake fonts-font-awesome fonts-roboto devscripts snapd file-roller pcmanfm pulseaudio pavucontrol alsa-utils numix-gtk-theme screenfetch feh build-essential gtk2-engines-murrine gtk2-engines vim ranger caca-utils highlight atool w3m poppler-utils mediainfo compton python-pip python3-pip libcanberra-gtk-module libgtk2.0-dev libgtk-3-dev gnome-devel dolphin imagemagick scrot nnn tig arandr htop mesa-utils mesa-utils-extra emacs xsel bluez-cups blueman gpick tree ninja-build gettext libtool-bin g++ unzip firmware-linux-nonfree firmware-iwlwifi jq firmware-realtek nmap zeal thunderbird ack libfile-next-perl neofetch chromium crda

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
wget https://snwh.org/paper/download.php?owner=snwh&ppa=ppa&pkg=paper-icon-theme,18.04
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

### deadbeef plugins
rsync -a -v .local/ $HOME/.local/

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

### Throw a newer kernel inside
sudo apt install linux-image-5.4.0-0.bpo.4-amd64 linux-headers-5.4.0-0.bpo.4-amd64

### Fix potential wifi bug with newer Kernel
sudo modprobe -r rtwpci
sudo mkdir /usr/lib/firmware/rtw88
sudo ln -s /usr/lib/firmware/rtlwifi/rtl8822befw.bin /usr/lib/firmware/rtw88/rtl8822b_fw.bin
sudo ln -s /usr/lib/firmware/rtlwifi/rtl8822befw.bin /usr/lib/firmware/rtw88/rtw8822b_fw.bin
sudo modprobe rtwpci

### Enable systemd-networkd
sudo systemctl enable systemd-networkd.service

### Boot into command line
sudo systemctl set-default multi-user.target

echo "Installation done..."
sleep 1
echo "Please reboot your system"
