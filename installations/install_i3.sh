#!/bin/bash

echo "Installing i3..."
sleep 1

### Stuff to build i3
sudo apt install -y libpango1.0-dev libyajl-dev libstartup-notification0-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf xutils-dev libtool automake pkg-config libpam-dev libcairo-dev libfontconfig-dev libx11-xcb-dev libev-dev libjpeg-dev libxcb*

### Install i3 base
sudo apt install -y i3

### Build i3-gaps itself
cd /tmp/
git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps
git checkout gaps && git pull
autoreconf --force --install
rm -rf build
mkdir build
cd build
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make
sudo make install

### Install cool features
sudo apt install -y rofi i3lock i3status

### Build i3lock-color
cd /tmp/
git clone https://github.com/PandorasFox/i3lock-color.git
cd i3lock-color
autoreconf --force --install
rm -rf build/
mkdir -p build && cd build/
../configure \
  --prefix=/usr \
  --sysconfdir=/etc \
  --disable-sanitizers
make

### install i3lock-fancy
cd /tmp/
git clone https://salsa.debian.org/debian/i3lock-fancy
cd i3lock-fancy
cp lock lock.png /usr/local/bin/
