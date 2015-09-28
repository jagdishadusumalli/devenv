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

pretty_print "Installing NodeJs..."
  brew install node

pretty_print "Upgrading npm to latest..."
  npm install -g npm@latest

pretty_print "Installing Grunt..."
  npm install -g grunt-cli

# pretty_print "Installing Composer..."
#   brew update
#   brew install composer

pretty_print "Installing Bower..."
  npm install -g bower

pretty_print "Installing Gulp..."
  npm install -g gulp

pretty_print "Installing ionic..."
  npm install -g ionic

pretty_print "Installing cordova..."
  npm install -g cordova

pretty_print "Installing ios-deploy..."
  npm install -g ios-deploy