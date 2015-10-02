#bin/bash
USER=$(whoami)
NOW=$(date +"%Y-%m-%d_%H-%M")
EMAIL_SUBJECT="the stack-versions of $USER as of $NOW"
TO_ADDRESS="dipanjan@qiddle.com"
bold=$(tput bold)
ul=$(tput smul)
rul=$(tput rmul)
blue=$(tput setaf 4)
green=$(tput setaf 5)
normal=$(tput sgr0)

#pretty_print() {
#  printf "${blue}${bold}\n%b\n\n${normal}" "$1"
#}
{	
	echo "Showing installed ionic stack info : " 
	ionic info
	echo "Showing installed npm version info : " 
	npm -v

	echo "Showing installed bower version info : " 
	bower -version

	echo "Showing installed Cordova Platform info : "
	cordova platform version android

	echo "Showing installed brew config info : "
	brew config

	echo "Showing installed postgres version info: " 
	psql --version

	echo "Showing Android tools and Platform-tools version info :"
	if [ "$(uname)" == "Darwin" ]; then
	    cat /usr/local/opt/android-sdk/tools/source.properties | grep Pkg.Revision
	    cat /usr/local/opt/android-sdk/platform-tools/source.properties | grep Pkg.Revision 
	fi

	echo "Showing outdated npm packages: " 
	npm -g outdated
}>>.tmp
EMAIL_BODY=$(cat .tmp)
echo "$EMAIL_BODY" | mail -s "$EMAIL_SUBJECT" $TO_ADDRESS
rm .tmp
