#!/bin/bash

echo "Installing non apt applications..."
sleep 1

### Installing custom applications from github
cd /tmp/

### Install Alacritty
wget https://github.com/alacritty/alacritty/releases/download/v0.4.2/Alacritty-v0.4.2-ubuntu_18_04_amd64.deb 
sudo dpkg -i Alacritty*.deb

### Install bat
wget https://github.com/sharkdp/bat/releases/download/v0.13.0/bat_0.13.0_amd64.deb
sudo dpkg -i bat*.deb

### Install neovim
git clone https://github.com/neovim/neovim.git
cd neovim/
git checkout stable
make CMAKE_BUILD_TYPE=Release
sudo make install
cd /tmp/

### Install neovim plugins
curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
pip3 install --user neovim

mkdir -p $HOME/.config/nvim/plugged/
cp $SCRIPTPATH/.config/nvim/init.vim $HOME/.config/nvim/

nvim -c PlugInstall -c UpdateRemotePlugins -c quitall

### Install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

### Install Visual Code
wget -O code.deb "https://go.microsoft.com/fwlink/?LinkID=760868"
sudo dpkg -i code.deb

### Install Visual Code plugins
while read p; do
    code --force --install-extension $p
done <$SCRIPTPATH/installations/code_extensions

### Install Spotify
sudo snap install spotify
