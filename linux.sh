
##### DO Server User and security setup
# Create a slice on DO adding ssh keys available on server (freewave)
# This adds the freewave's public key to the root user (.ssh/authorized_keys file) which lets you login as root
# using the freewave.pem (private key) file and no password.

# Create a user with sudo privileges - $adduser jagsuser
# modify sudoers file - $sudo visudo
# add to the file - $jagsuser ALL=(ALL:ALL) ALL
# Login as jagsuser
# Copy the freewave's authorised_keys file from root user to jagsuser and change privileges
#$sudo cp /root/.ssh/authorized_keys .ssh/
#$sudo chown jagsuser:jagsuser .ssh/authorized_keys

##### Setup the locale as required 
#$sudo locale-gen en_IN.UTF-8 or
#$sudo locale-gen en_US.UTF-8
#printf "export LC_ALL=en_US.UTF-8 \nexport LANG=en_US.UTF-8" > ~/.bashrc
# Login as demouser and execute the script

____________________________________________________________________________________


#!/bin/bash -v
# In Sources Change "Server in India" to "Main" for faster downloads

# clean up unwanted apps and update upgrade
############################################################
printf "\n\n====== Cleaning up unwanted apps and reduce upgrades size ============ \n\n\n"
sudo apt-get -y autoremove --purge thunderbird empathy gnome-sudoku gnome-mahjongg gnome-mines aisleriot indicator-messages telepathy-indicator
sudo apt-get -y autoremove --purge unity-lens-shopping unity-lens-music unity-lens-photos unity-lens-gwibber unity-lens-video
#sudo apt-get -y autoremove --purge libreoffice*
printf "\n\n====== Runnig autoclean and autoremove  ============ \n\n\n"
#sudo apt-get -y autoclean
#sudo apt-get -y autoremove
#dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | xargs sudo apt-get -y purge


# show all startup applications
sudo sed -i "s/NoDisplay=true/NoDisplay=false/g" /etc/xdg/autostart/*.desktop

# Adding all PPA repos for Desktop
############################################################
printf "\n\n====== Adding PPA Repositories desktop  ============ \n\n\n"
printf "\n\n====== GOOGLE repositories adding for chroma and hangouts  ============ \n\n\n"
sudo sh -c 'echo "deb http://dl.google.com/linux/talkplugin/deb/ stable main" >> /etc/apt/sources.list.d/google-talkplugin.list'
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo sh -c 'wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
printf "\n\n====== Virtualbox repository adding  ============ \n\n\n"
sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian $(lsb_release -sc) contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list'
sudo sh -c 'wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add -'
printf "\n\n====== UBUNTU-TWEAK repository adding  ============ \n\n\n"
sudo sh -c 'add-apt-repository -y ppa:tualatrix/ppa'
printf "\n\n====== vlc repository Adding  ============ \n\n\n"
sudo sh -c 'add-apt-repository -y ppa:videolan/stable-daily'
printf "\n\n====== ORACLE JAVA repository adding  ============ \n\n\n"
sudo sh -c 'add-apt-repository -y ppa:webupd8team/java'
printf "\n\n====== Y-PPA repository adding  ============ \n\n\n"
sudo sh -c 'add-apt-repository -y ppa:webupd8team/y-ppa-manager'
printf "\n\n====== CANONICAL PARTNER repository Adding  ============ \n\n\n"
sudo sh -c 'add-apt-repository -y "deb http://archive.canonical.com/ $(lsb_release -sc) partner"'

#Install sublime text 3 manually from deb file
# Server setup
############################################################
# Adding all PPA repos for ror server apps
############################################################
printf "\n\n====== apt-add-repository installing  ============ \n\n\n"
#sudo apt-get -y install software-properties-common
#sudo apt-get -y install python-software-properties
#sudo apt-get -y update

printf "\n\n====== Adding PPA Repositories for ROR Server n Development   ============ \n\n\n"
printf "\n\n====== NGINX repository adding  ============ \n\n\n"
sudo sh -c 'add-apt-repository -y ppa:nginx/stable'
printf "\n\n====== POSTGRESQL repository adding  ============ \n\n\n"
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
sudo sh -c 'wget -q -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | apt-key add -'

#printf "\n\n====== APT-FAST repository adding  ============ \n\n\n"
#sudo sh -c 'add-apt-repository -y ppa:apt-fast/stable'

# Doing apt-get update and dist-upgrade
############################################################
printf "\n\n====== About to update package list  ============ \n\n\n"
sudo apt-get -y update
printf "\n\n====== About to dist-upgrade all packages  ============ \n\n\n"
sudo apt-get -y dist-upgrade
sudo apt-get -y autoremove

# Installing Common Desktop/ Server applications
############################################################
#printf "\n\n====== apt-fast app installing  ============ \n\n\n"
#sudo apt-get -y install apt-fast

# Installing server applications
############################################################
printf "\n\n====== DEV ESSENTIALS installing  ============ \n\n\n"
sudo apt-get -y install build-essential git-core vim curl tmux zsh htop tree s3cmd nmap 
printf "\n\n====== GENERAL APPDEV DEPENDENCIES installing  ============ \n\n\n"
sudo apt-get -y install redis-server imagemagick libmagickcore-dev libmagickwand-dev libqt4-dev 
printf "\n\n====== NGINX and dep libs installing  ============ \n\n\n"
sudo apt-get -y install libcurl4-openssl-dev nginx
printf "\n\n====== POSTGRESQL installing  ============ \n\n\n"
sudo apt-get -y install postgresql-9.5 postgresql-client-9.5 libpq-dev postgresql-contrib-9.5
printf "\n\n====== PostgreSQL User Setup (root/root123) ============ \n\n\n"
sudo su postgres <<-'EOF'
createuser -d -e -E -l -r -s root
psql -c "ALTER USER root with password 'root'"
EOF

printf "\n\n====== RBENV or RVM requirements installing  ============ \n\n\n"
sudo apt-get -y install zlib1g-dev libssl-dev libreadline-dev tklib libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev

#Installing Nodejs 5.0.0
\curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
sudo apt-get -y install nodejs
sudo npm install -g npm@latest

#printf "\n\n====== Additional RVM requirements installing  ============ \n\n\n"
#sudo apt-get -y install gawk libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libgdbm-dev libncurses5-dev autoconf automake libtool bison libffi-dev

#curl based installations
#################################################################

printf "\n\n======  RBENV Installing   ============ \n\n\n"
printf "export PATH="$HOME/.rbenv/bin:$PATH"  # Setting up rbenv in PATH.\n" >> ~/.bashrc
printf 'eval "$(rbenv init - --no-rehash)"' >> ~/.bashrc
\curl https://raw.githubusercontent.com/fesplugas/rbenv-installer/master/bin/rbenv-installer | bash
printf "bundler \nrails"  >> ~/.rbenv/default-gems

###Manual Installations
################################################################
 source ~/.bashrc
 printf "\n\n======  Ruby 2.2.3 with gems Installing   ============ \n\n\n"
 rbenv install 2.2.3

printf "install: --no-document \nupdate: --no-document" > ~/.gemrc
#printf "\n\n====== showing ruby and rubygems version  ============ \n\n\n"
#ruby -v
#gem --version
#printf "\n\n====== trying to update rubygems  ============ \n\n\n"
#gem update --system
#printf "\n\n====== install rails  ============ \n\n\n"
#gem install rails
#source ~/.bashrc

printf "\n\n====== ohmyzsh installing  ============ \n\n\n"
\curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
printf "\n\n====== Changing shell to zsh  ============ \n\n\n"
sudo chsh -s $(which zsh) $(whoami)

# Installing Desktop applications
############################################################
printf "\n\n====== CHROME and HANGOUTS google-talkplugin installing   ============ \n\n\n"
sudo apt-fast -y install google-chrome-stable google-talkplugin
printf "\n\n====== Gnome and Unity Tweak Tools installing   ============ \n\n\n"
sudo apt-fast -y install ubuntu-tweak unity-tweak-tool gnome-tweak-tool
printf "\n\n====== Admin and System Tools installing   ============ \n\n\n"
sudo apt-fast -y install synaptic bleachbit bum y-ppa-manager indicator-multiload 
printf "\n\n====== Development frontend tools  ============ \n\n\n"
sudo apt-fast -y install gitk git-gui pgadmin3 
printf "\n\n====== System config information tools installing   ============ \n\n\n"
sudo apt-fast -y install hwinfo lshw-gtk hardinfo sysinfo
printf "\n\n====== Samba Tools installing  ============ \n\n\n"
sudo apt-fast -y install samba system-config-samba nautilus-share
printf "\n\n====== VLC n ubuntu-restricted-extras codecs installing  ============ \n\n\n"
sudo apt-fast -y install vlc ubuntu-restricted-extras

#printf "\n\n====== Google drive tools installing  ============ \n\n\n"
#sudo apt-fast -y install grive-tools
#printf "\n\n====== dropbox installing  ============ \n\n\n"
#sudo apt-fast -y install dropbox

#sudo apt-get -y install gimp gimp-plugin-registry
#printf "\n\n====== handbrake installing  ============ \n\n\n"
#sudo apt-get -y install handbrake-gtk handbrake-cli
#printf "\n\n====== inkscape installing  ============ \n\n\n"
#sudo apt-get -y install inkscape
#printf "\n\n====== Virtualbox 4 installing  ============ \n\n\n"
#sudo apt-get -y install virtualbox
printf "\n\n====== ubuntu-restricted-extras codecs installing  ============ \n\n\n"
sudo apt- -y install ubuntu-restricted-extras

# Installing ATTENDED Desktop applications 
############################################################


#auto tgz download and compile based installations (non deb)
#################################################################
printf "\n\n====== sublime-text-2 installing  ============ \n\n\n"
sudo apt-get -y install sublime-text 
printf "\n\n====== flashplugin installing  ============ \n\n\n"
sudo apt-get -y install flashplugin-installer
printf "\n\n====== Oracle java 7 installing ATTENDED ============ \n\n\n"
sudo apt-get -y install oracle-java8-installer
sudo apt-get -y install oracle-java8-set-default

printf "\n\n====== Refresh everything autoremove-update-dist-upgrade  ============ \n\n\n"
sudo apt-get -y autoremove
sudo apt-get -y update
sudo apt-get -y dist-upgrade

#printf "\n\n====== Intel Graphics Drivers Repo adding  ============ \n\n\n"
#sudo sh -c 'wget --no-check-certificate https://download.01.org/gfx/RPM-GPG-KEY-ilg -O - | apt-key add -'
#sudo sh -c 'wget --no-check-certificate https://download.01.org/gfx/RPM-GPG-KEY-ilg-2 -O - | apt-key add -'
#sudo sh -c 'echo "deb https://download.01.org/gfx/ubuntu/13.04/main Ubuntu 13.04" >> /etc/apt/sources.list.d/intel-graphics.list'
#sudo apt-get install intel-linux-graphics-installer

###PPA's on standby
###########################################################
#printf "\n\n====== Installing skype wrapper repository  ============ \n\n\n"
#sudo add-apt-repository -y ppa:skype-wrapper/ppa
#printf "\n\n====== installing faenza-icon repository  ============ \n\n\n"
#sudo add-apt-repository -y ppa:tiheum/equinox
#printf "\n\n====== installing webupd8team repository  ============ \n\n\n"
#sudo add-apt-repository -y ppa:webupd8team/themes
#printf "\n\n====== installing noobslab repository  ============ \n\n\n"
#sudo add-apt-repository -y ppa:noobslab/themes
#printf "\n\n====== installing nemo repository  ============ \n\n\n"
#sudo add-apt-repository -y ppa:gwendal-lebihan-dev/cinnamon-stable
#printf "\n\n====== heroku toolbelt repository adding  ============ \n\n\n"
#sudo sh -c 'echo "deb http://toolbelt.heroku.com/ubuntu ./" > /etc/apt/sources.list.d/heroku.list'
#sudo sh -c 'wget -O- https://toolbelt.heroku.com/apt/release.key | apt-key add -'


###Installations on standby
############################################################
#sudo apt-get -y install terminator
#sudo apt-get install skype-wrapper
#sudo apt-get -y install nemo nemo-fileroller
# appearence
############
#sudo apt-get -y install faenza-icon-theme faience-*
#sudo apt-get -y install gnome-cupertino-gtk-theme
# zukiwi
#sudo apt-get -y install zukitwo-theme zukitwo zukiwi
#sudo apt-get -y install compizconfig-settings-manager compiz-plugins-extra
# $ sudo add-apt-repository ppa:gwendal-lebihan-dev/cinnamon-stable
# $ sudo apt-get update
# $ sudo apt-get install nemo
# If the installation has been done successfully, let's make Nemo the default file manager on Ubuntu:
# $ xdg-mime default nemo.desktop inode/directory application/x-gnome-saved-search
# $ gsettings set org.gnome.desktop.background show-desktop-icons false
# $ gsettings set org.nemo.desktop show-desktop-icons true
# By default, Nemo is not added in the Startup Application list, to unlock it, just use this oneliner:
# sudo sed -i 's/NoDisplay=true/NoDisplay=false/g' /etc/xdg/autostart/nemo-autostart.desktop

### Not So Important Desktop Apps
####################################################################
#printf "\n\n====== LIBROFFICE repository Adding  ============ \n\n\n"
#sudo sh -c 'add-apt-repository -y ppa:libreoffice/ppa'
#printf "\n\n====== GOOGLE DRIVE tools repository adding  ============ \n\n\n"
#sudo sh -c 'sudo add-apt-repository -y ppa:thefanclub/grive-tools'
#printf "\n\n====== DROPBOX repository adding  ============ \n\n\n"
#sudo sh -c 'echo "deb http://linux.dropbox.com/ubuntu/ $(lsb_release -sc) main" >> /etc/apt/sources.list.d/dropbox.list'
#sudo sh -c 'add-apt-repository "deb http://linux.dropbox.com/ubuntu $(lsb_release -sc) main"'
#sudo sh -c 'apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E'
#printf "\n\n====== GIMP repository adding  ============ \n\n\n"
#sudo sh -c 'add-apt-repository -y ppa:otto-kesselgulasch/gimp'
#printf "\n\n====== HANDBRAKE repository adding  ============ \n\n\n"
#sudo sh -c 'add-apt-repository -y ppa:stebbins/handbrake-releases'
#printf "\n\n====== INKSCAPE repository adding  ============ \n\n\n"
#sudo sh -c 'add-apt-repository -y ppa:inkscape.dev/stable'
#printf "\n\n====== heroku toolbelt installing  ============ \n\n\n"
#sudo apt-get -y install heroku-toolbelt


#!/bin/bash
