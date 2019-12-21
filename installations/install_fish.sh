#!/bin/bash

echo "Installing fish shell..."
sleep 1

### Install fish
sudo apt install -y fish-common fish

### install oh-my-fish
omf=$(curl -L https://get.oh-my.fish)
fish -c "$omf --noninteractive --verbose"
fish -c "omf install scorphish; omf theme scorphish"
