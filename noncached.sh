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

pretty_print "Installing android-sdk tools and platforms”
pretty_print "To save time you can also copy these packages from /usr/local/var/lib/android-sdk of another installed system"
#http://stackoverflow.com/questions/17963508/how-to-install-android-sdk-build-tools-on-the-command-line
echo "y" | android update sdk -u -a -t tools,platform-tools,build-tools-23.0.0,android-16,android-17,android-18,android-19,android-21,android-22,android-23,extra-android-m2repository,extra-android-support,extra-google-google_play_services,extra-google-m2repository,extra-intel-Hardware_Accelerated_Execution_Manager