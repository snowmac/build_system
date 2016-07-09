#!/bin/bash

echo "--> Sublime: Checking for sublime and installing it if we don't have it "
# Sublime settings
if ! [ -e /Applications/Sublime\ Text.app ]; then
  echo '---> Please install sublime text'
  echo '---> Skipping the sublime section'
else
  echo '--> Sublime: Ensuring we can add the sublime preferences'
  $(chmod -R 777 '/Users/adambourg/Library/Application Support/Sublime Text 3/Installed Packages/')

  echo "--> Sublime: Updating Sublime settings"
  # Replace existing settings
  cp dependencies/sublime/Preferences.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/

  echo "--> Sublime: Creating SUBLIME CLI command"
  # Create Link for sublime cli
  ln -s  "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl
  $(source ~/.bash_profile)
  $(source ~/.zshrc)

  echo "--> Sublime: Adding package control"
  # Add Package Control
  if [ -e ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages/ ]; then
    cp -r dependencies/sublime/packages/* ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages
  fi
fi
