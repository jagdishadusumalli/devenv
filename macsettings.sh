#!/bin/bash

###############################################################################
# General UI/UX
###############################################################################

echo ""
echo "Would you like to set your computer name (as done via System Preferences >> Sharing)?  (y/n)"
read -r response
case $response in
  [yY])
      echo "What would you like it to be?"
      read COMPUTER_NAME
      sudo scutil --set ComputerName $COMPUTER_NAME
      sudo scutil --set HostName $COMPUTER_NAME
      sudo scutil --set LocalHostName $COMPUTER_NAME
      sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $COMPUTER_NAME
      break;;
  *) break;;
esac


# echo ""
# echo "Check for software updates daily, not just once per week"
# defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1



################################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input
###############################################################################

# echo ""
# echo "Increasing sound quality for Bluetooth headphones/headsets"
# defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40


###############################################################################
# Finder
###############################################################################

# echo ""
# echo "Show hidden files in Finder by default? (y/n)"
# read -r response
# case $response in
#   [yY])
#     defaults write com.apple.Finder AppleShowAllFiles -bool true
#     break;;
#   *) break;;
# esac

# echo ""
# echo "Show dotfiles in Finder by default? (y/n)"
# read -r response
# case $response in
#   [yY])
#     defaults write com.apple.finder AppleShowAllFiles TRUE
#     break;;
#   *) break;;
# esac

# echo ""
# echo "Show all filename extensions in Finder by default? (y/n)"
# read -r response
# case $response in
#   [yY])
#     defaults write NSGlobalDomain AppleShowAllExtensions -bool true
#     break;;
#   *) break;;
# esac

# echo ""
# echo "Use column view in all Finder windows by default? (y/n)"
# read -r response
# case $response in
#   [yY])
#     defaults write com.apple.finder FXPreferredViewStyle Clmv
#     break;;
#   *) break;;
# esac

echo ""
echo "Avoid creation of .DS_Store files on network volumes? (y/n)"
read -r response
case $response in
  [yY])
    defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
    break;;
  *) break;;
esac


echo ""
echo "Allowing text selection in Quick Look/Preview in Finder by default"
defaults write com.apple.finder QLEnableTextSelection -bool true


# echo ""
# echo "Enabling snap-to-grid for icons on the desktop and in other icon views"
# /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist


echo ""
echo "Enabling the Develop menu and the Web Inspector in Safari"
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true

echo ""
echo "Adding a context menu item for showing the Web Inspector in web views"
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true


# Use current directory as default search scope in Finder
echo ""
echo "Use current directory as default search scope in Finder"
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Show Path bar in Finder
echo ""
echo "Show Path bar in Finder"
defaults write com.apple.finder ShowPathbar -bool true

# Show Status bar in Finder
echo ""
echo "Show Status bar in Finder"
defaults write com.apple.finder ShowStatusBar -bool true

# Show indicator lights for open applications in the Dock
echo ""
echo "Show indicator lights for open applications in the Dock"
defaults write com.apple.dock show-process-indicators -bool true

# Set a blazingly fast keyboard repeat rate
echo ""
echo "Set a blazingly fast keyboard repeat rate"
defaults write NSGlobalDomain KeyRepeat -int 1

# Set a shorter Delay until key repeat
echo ""
echo "Set a shorter Delay until key repeat"
defaults write NSGlobalDomain InitialKeyRepeat -int 12

# Show the ~/Library folder
echo ""
echo "Show the ~/Library folder"
chflags nohidden ~/Library


###############################################################################
# Mail
###############################################################################

#echo ""
#echo "Setting email addresses to copy as 'foo@example.com' instead of 'Foo Bar <foo@example.com>' in Mail.app"
#defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

###############################################################################
# Terminal
###############################################################################

echo ""
echo "Enabling UTF-8 ONLY in Terminal.app and setting the Pro theme by default"
defaults write com.apple.terminal StringEncodings -array 4
defaults write com.apple.Terminal "Default Window Settings" -string "Pro"
defaults write com.apple.Terminal "Startup Window Settings" -string "Pro"

###############################################################################
# Time Machine
###############################################################################

echo ""
echo "Prevent Time Machine from prompting to use new hard drives as backup volume? (y/n)"
read -r response
case $response in
  [yY])
    defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true
    break;;
  *) break;;
esac

###############################################################################
# Transmission.app                                                            #
###############################################################################

echo ""
echo "Do you use Transmission for torrenting? (y/n)"
read -r response
case $response in
  [yY])
    echo ""
    echo "Use `~/Downloads/Incomplete` to store incomplete downloads"
    defaults write org.m0k.transmission UseIncompleteDownloadFolder -bool true
    mkdir -p ~/Downloads/Incomplete
    defaults write org.m0k.transmission IncompleteDownloadFolder -string "${HOME}/Downloads/Incomplete"

    echo ""
    echo "Don't prompt for confirmation before downloading"
    defaults write org.m0k.transmission DownloadAsk -bool false

    echo ""
    echo "Trash original torrent files"
    defaults write org.m0k.transmission DeleteOriginalTorrent -bool true

    echo ""
    echo "Hide the donate message"
    defaults write org.m0k.transmission WarningDonate -bool false

    echo ""
    echo "Hide the legal disclaimer"
    defaults write org.m0k.transmission WarningLegal -bool false
    break;;
  *) break;;
esac

###############################################################################
# Sublime Text
###############################################################################

# echo ""
# echo "Do you use Sublime Text 3 as your editor of choice, and is it installed?"
# read -r response
# case $response in
#   [yY])
#     # Installing from homebrew cask does the following for you!
#     # echo ""
#     # echo "Linking Sublime Text for command line usage as subl"
#     # ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl

#     echo ""
#     echo "Setting Git to use Sublime Text as default editor"
#     git config --global core.editor "subl -n -w"
#     break;;
#   *) break;;
# esac
