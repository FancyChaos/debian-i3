#!/bin/bash

### This script is for executing the main script and logging its output

### Start sudo session (will last 15minutes)
echo "Enter sudo password"
sudo echo ""

if [ "$?" != "0" ]; then
	exit
fi

### Get first boot argument
REBOOT="$1"
### Get path of script
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
export REBOOT
export SCRIPTPATH

### Install coreutils if they are not yet installed
sudo apt install -y coreutils

cd $SCRIPTPATH

### Execute the main script
bash $SCRIPTPATH/install.sh | tee $SCRIPTPATH/install.log
