#bin/bash

bold=$(tput bold)
ul=$(tput smul)
rul=$(tput rmul)
blue=$(tput setaf 4)
green=$(tput setaf 5)
normal=$(tput sgr0)

pretty_print() {
  printf "${blue}${bold}\n%b\n\n${normal}" "$1"
}

pretty_print "Showing installed ionic stack info : " 
ionic info
pretty_print "Showing installed npm version info : " 
npm -v

pretty_print "Showing installed bower version info : " 
bower -version

pretty_print "Showing installed Cordova Platform info : "
cordova platform version android

pretty_print "Showing installed brew config info : "
brew config

pretty_print "Showing installed postgres version info: " 
psql --version

pretty_print "Showing Android tools and Platform-tools version info :"
if [ "$(uname)" == "Darwin" ]; then
    cat /usr/local/opt/android-sdk/tools/source.properties | grep Pkg.Revision
    cat /usr/local/opt/android-sdk/platform-tools/source.properties | grep Pkg.Revision 
fi

pretty_print "Showing outdated npm packages: " 
npm -g outdated


