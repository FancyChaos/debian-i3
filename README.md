# debian-i3
My own scripts to setting up an i3 environment from a freshly installed Debian Buster (10)


## Installation

 1. Install a new Debian Buster (10) base system
 2. Open your Terminal and install git
	> sudo apt install git
 3. Clone this repository and move into it
	> git clone https://github.com/FancyChaos/debian-i3.git && cd debian-i3
 4. Make the run.sh script executable if necessary and run it as sudo
	> chmod +x run.sh && sudo ./run.sh \<username>

	The username is the user you want to install i3 for. This is necessary get the correct home directory.
	If you provide anything as the second argument the system will reboot after the installation finished.
	
	The **run.sh** script will create an **install.log** file inside the cloned repository which will include all actions done by the scripts.

After the reboot you can start my own home/work setup by executing the `starti3` script.

    starti3 home
    or
    starti3 work


## Known bugs/quirks
- Neovim plugin installation
	- The Command `sudo -H -u $SPECIFIEDUSER nvim -c PlugInstall -c UpdateRemotePlugins -c quitall` won't really work right now. To enable the nvim plugins you need to execute the command `PlugInstall` and `UpdateRemotePlugins` inside nvim by yourself.
- Network problems
	- On my notebook it's not possible to get the wifi working before the installation is done. That means that you need to hook up an Ethernet cable (Maybe you have more luck with your notebook).


## Adding own i3 customization
Adding your custom i3 configs is really simple. Just create a new i3 config inside **/home/\<user>/.config/i3/** with the name `config_<name>`. On startup you can just execute `starti3 <name>` to load you own i3 config before starting the xserver.

#### Example:
A config file called `config_school` was created inside the **/home/\<user>/.config/i3/** directory.
Now you can load this config by executing `starti3 school` on startup.


## Issues after latest "real" test run (non VM)
The latest test run on my home desktop PC revealed following issues:

 1. vim-plug does not install plugins
 2. Visual Code does not install plugins
 3. OMF installation failed
 4. Topgrade installation failed

This list will be updated after every new test run on my home PC (which won't be very often).
So some of these issues might have been fixed by now.


## Thanks to
Thanks to [Soleedus](https://github.com/Soleedus/debian-i3gaps) who gave me the inspiration for a debian i3 setup script.

And of course thanks to everyone I stole scripts, wallpapers or snippets from.
