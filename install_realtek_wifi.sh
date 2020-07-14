#!/bin/bash

ask () {
	printf "$@ (y/n): "
	read con
	if [ "$con" != "y" ] && [ "$con" != "Y" ]; then
		return 0
	fi
	return 1
}

echo "This will compile and install the newest rtw88 driver for the Realtek chipset"
echo "I used it to successfully install drivers for the Realtek RTL8822be chipset"
ask "Continue?"
if [ $? -eq 0 ]; then
	echo "Exiting..." && exit 0
fi
echo ""

chipset=$( sudo lspci | grep Network )
if [[ ! $chipset == *"Realtek"* ]]; then
	echo "Your device does not have a Realtek chipset"
	ask "Install Realtek wifi drivers anyway?"
	if [ $? -eq 0 ]; then
		echo "Exiting..." && exit 0
	fi
	echo ""
fi

# install build essentials (Propably already installed)
sudo apt install mokutil git build-essential

# Clone repo for rtw88 driver
cd /tmp/
git clone https://github.com/lwfinger/rtw88.git
cd rtw88
# Install the drivers
# TODO: Add error handling
make
sudo make install

# Lock kernel if wished
echo "You need to install the drivers again if you update your Kernel."
echo "Thats why it's recommened to lock the current kernel (disallow updates)"

ask "Lock the kernel to the current version?"
if [ $? -eq 1 ]; then
	sudo apt-mark hold "linux-image*" "linux-headers*" linux-libc-dev
fi

echo ""
echo "Kernel version locked"
echo "You can unlock the kernel with 'sudo apt-get unhold *'"
echo ""

echo "Driver installed. Please reboot the system"
