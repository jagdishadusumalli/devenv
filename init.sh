#!/bin/bash

# Some things taken from here
# https://github.com/mathiasbynens/dotfiles/blob/master/.osx
bold=$(tput bold)
ul=$(tput smul)
rul=$(tput rmul)
blue=$(tput setaf 4)
green=$(tput setaf 5)
normal=$(tput sgr0)

pretty_print() {
  printf "\n%b\n" "$1"
}

pretty_print "setting up your dev environment like a boss..."

# Set continue to false by default
CONTINUE=false

echo ""
pretty_print "###############################################"
pretty_print "#        DO NOT RUN THIS SCRIPT BLINDLY       #"
pretty_print "#         YOU'LL PROBABLY REGRET IT...        #"
pretty_print "#                                             #"
pretty_print "#              READ IT THOROUGHLY             #"
pretty_print "#         AND EDIT TO SUIT YOUR NEEDS         #"
pretty_print "###############################################"
echo ""

echo ""
pretty_print "Have you read through the script you're about to run and "
pretty_print "understood that it will make changes to your computer? (y/n)"
read -r response
case $response in
  [yY]) CONTINUE=true
      break;;
  *) break;;
esac

if ! $CONTINUE; then
  # Check if we're continuing and output a message if not
  pretty_print "Please go read the script, it only takes a few minutes"
  exit
fi

# Here we go.. ask for the administrator password upfront and run a
# keep-alive to update existing `sudo` time stamp until script has finished
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

pretty_print "Setting up some good default settings for your mac"
  #sh macsettings.sh


# xcode dev tools
  pretty_print "Installing xcode dev tools..."
  xcode-select --install

# ## xquartz
#   pretty_print "Installing xquartz..."
#   curl http://xquartz-dl.macosforge.org/SL/XQuartz-2.7.7.dmg -o /tmp/XQuartz.dmg
#   open /tmp/XQuartz.dmg

# Oh my zsh installation
pretty_print "Installing oh-my-zsh..."
  curl -L http://install.ohmyz.sh | sh

# zsh fix
if [[ -f /etc/zshenv ]]; then
  pretty_print "Fixing OSX zsh environment bug ..."
    sudo mv /etc/{zshenv,zshrc}
fi

# Homebrew installation
if ! command -v brew &>/dev/null; then
  pretty_print "Installing Homebrew, an OSX package manager, follow the instructions..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  if ! grep -qs "recommended by brew doctor" ~/.zshrc; then
    pretty_print "Put Homebrew location earlier in PATH ..."
      printf '\n# recommended by brew doctor\n' >> ~/.zshrc
      printf 'export PATH="/usr/local/bin:$PATH"\n' >> ~/.zshrc
      printf 'export PATH="/usr/local/bin:$PATH"\n' >> ~/.bashrc

      export PATH="/usr/local/bin:$PATH"
  fi
else
  pretty_print "You already have Homebrew installed...good job!"
fi


pretty_print "Setup some rc files for cask options etc"

printf 'export HOMEBREW_CASK_OPTS="--appdir=/Applications"\n' >> ~/.zshrc
printf 'export HOMEBREW_CASK_OPTS="--appdir=/Applications"\n' >> ~/.bashrc
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

pretty_print "Setup gemrc for default options"
  if [ ! -f ~/.gemrc ]; then
    printf 'gem: --no-document' >> ~/.gemrc
  fi

pretty_print "If you get permission errors on /usr/local folder run"
pretty_print "sudo chown -R `whoami` /usr/local or"
pretty_print "sudo chown -R "$USER":admin /usr/local"
pretty_print "sudo chown -R $USER:admin /Library/Caches/Homebrew"

pretty_print "Installing Homebrew utilities and libs"
  sh brewapps.sh

pretty_print "Setting up Nodejs and npm apps"
  sh npmapps.sh

# Install brew cask and apps
pretty_print "Installing Mac OS X apps...i.e. brew cask and apps "
  sh macapps.sh

pretty_print "Installing amazon cli tools"
  pip install awscli 

pretty_print "Installing noncached apps"
  #sh noncached.sh

pretty_print "Setting up ror dev env"
  sh ror.sh

# when done with cask
brew update && brew upgrade brew-cask && brew cleanup #&& brew cask cleanup

pretty_print "Finally displying the complete brew configs"
sh showconfig.sh

# pretty_print "Installing fonts..."
#   sh fonts.sh

# iterm
# pretty_print "Setup iterm..."
#   cd ~
#   curl -O https://raw.githubusercontent.com/nicolashery/mac-dev-setup/master/.bash_profile
#   curl -O https://raw.githubusercontent.com/nicolashery/mac-dev-setup/master/.bash_prompt
#   curl -O https://raw.githubusercontent.com/nicolashery/mac-dev-setup/master/.aliases

# Install Mackup
#pretty_print "Installing Mackup..."
#  brew install mackup

# Launch it and back up your files
#pretty_print "Running Mackup Backup..."
#  mackup backup

###############################################################################
# Kill affected applications
###############################################################################

echo ""
pretty_print "Shits Done Bro! You still need to manually install"
pretty_print "pacakge installer within sublime, setup your hosts, httpd.conf and vhosts files"
pretty_print "download chrome extensions, setup your hotspots/mouse settings, and setup your git shit"
echo ""
echo ""
pretty_print "################################################################################"
echo ""
echo ""
pretty_print "Note that some of these changes require a logout/restart to take effect."
pretty_print "Killing some open applications in order to take effect."
echo ""

find ~/Library/Application\ Support/Dock -name "*.db" -maxdepth 1 -delete
for app in "Activity Monitor" "Address Book" "Calendar" "Contacts" "cfprefsd" \
  "Dock" "Finder" "Mail" "Messages" "Safari" "SystemUIServer" \
  "Terminal" "Transmission"; do
  killall "${app}" > /dev/null 2>&1
done

#==============================================================================

# # php
# pretty_print "Installing php 5.6..."
#   brew tap homebrew/versions
#   brew tap homebrew/homebrew-php
#   brew install php56
#   echo 'export PATH="$(brew --prefix homebrew/php/php56)/bin:$PATH"' >> ~/.zshrc && . ~/.zshrc
# pretty_print "Setup auto start"
#   mkdir -p ~/Library/LaunchAgents
#   cp /usr/local/Cellar/php56/5.6.2/homebrew.mxcl.php56.plist ~/Library/LaunchAgents/

# mysql/mariadb
# pretty_print "Installing mysql..."
#   brew install mysql
#   brew unlink mysql
# pretty_print "Installing mariadb..."
#   brew install mariadb # Install MariaDB
#   # mysql setup auto start and start the database
#   ln -sfv /usr/local/opt/mysql/*.plist ~/Library/LaunchAgents
#   launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist
#   # Run the Database Installer
#   unset TMPDIR
#   cd /usr/local/Cellar/mariadb/{VERSION}
#   mysql_install_db
#   mysql.server start # Start MariaDB
#   mysql_secure_installation # Secure the Installation