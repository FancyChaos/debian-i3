#!/bin/bash

echo "Installing fish shell..."
sleep 1

### Install fish
sudo apt install -y fish-common fish

### install oh-my-fish
omf=$(curl -L https://get.oh-my.fish)
sudo -H -u $SPECIFIEDUSER fish -c "$omf --noninteractive"
sudo -H -u $SPECIFIEDUSER fish -c "omf install scorphish; omf theme scorphish"
