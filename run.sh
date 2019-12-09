#!/bin/bash

### This script is for executing the main script and logging its output

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

### Install coreutils if they are not yet installed
sudo apt install -y coreutils

cd $SCRIPTPATH

### Execute the main script
bash $SCRIPTPATH/install.sh "$@" | tee $SCRIPTPATH/install.log
