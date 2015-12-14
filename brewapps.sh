#!/bin/bash
bold=$(tput bold)
ul=$(tput smul)
rul=$(tput rmul)
blue=$(tput setaf 4)
green=$(tput setaf 5)
normal=$(tput sgr0)

pretty_print() {
  printf "\n%b\n" "$1"
}

# Homebrew OSX libraries

pretty_print "Installing cask to install apps"
  brew install caskroom/cask/brew-cask
  brew tap caskroom/versions

pretty_print "Updating brew formulas"
    brew update

pretty_print "Installing GNU core utilities..."
  brew install coreutils

pretty_print "Installing GNU find, locate, updatedb and xargs..."
  brew install findutils

pretty_print "Installing Bash 4"
  brew install bash libyaml libffi

# OpenSSL linking
pretty_print "Installing and linking OpenSSL..."
brew install openssl
brew link openssl --force

pretty_print "Installing the most recent verions of some OSX tools"
  brew tap homebrew/dupes
  brew tap homebrew/services

printf 'export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"' >> ~/.zshrc
export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"

# Git installation
pretty_print "Installing git for control version"
  brew install git
  curl -O https://raw.githubusercontent.com/nicolashery/mac-dev-setup/master/.gitconfig
  #git config --global user.name "Jagdish Adusumalli"
  #git config --global user.email "jagdishadusumalli@gmail.com"

# Image magick installation
pretty_print "Installing image magick for image processing"
  brew install imagemagick

pretty_print "Installing python"
  brew install python

pretty_print "Installing dnsmasq ack ios-sim"
  brew install dsnmasq ack ios-sim

pretty_print "Installing android-sdk"
  brew install android-sdk
  printf 'export ANDROID_HOME="/usr/local/opt/android-sdk"\n' >> ~/.bashrc
  printf 'export ANDROID_HOME="/usr/local/opt/android-sdk"\n' >> ~/.zshrc

pretty_print "Installing postgresql"
  brew install postgresql
pretty_print "Initialising postgresql datastore"
  initdb -D /usr/local/var/postgres/ -E utf8
pretty_print "Setting up LaunchAgents for postgresql"
  ln -sfv /usr/local/opt/postgresql/*.plist ~/Library/LaunchAgents
  launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
  psql postgres -c 'CREATE EXTENSION "adminpack";'

pretty_print "Installing redis"
  brew install redis

pretty_print "Installing sqlite"
  brew install sqlite
  
#pretty_print "Installing qt"
#  brew install qt

#pretty_print "Installing lame ffmpeg youtube-dl"
#  brew install lame ffmpeg youtube-dl
