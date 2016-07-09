#!/bin/sh

echo "Starting Adam Bourg's install script"
echo "-------------------------------------------------"

echo "--> Checking for Homebrew"
# Check to see if we have homebrew, if not lets get it
if ! type brew &> /dev/null; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  $(source ~/.bash_profile)
  $(source ~/.zshrc)
fi

echo "--> Getting wget"
# Homebrew install wget
brew install wget

$(source ~/.bash_profile)
$(source ~/.zshrc)

echo "--> Setting up git config"
# Install git config
cp dependencies/.gitconfig ~/

$(source ~/.bash_profile)
$(source ~/.zshrc)

echo "--> Getting oh-my-zsh"
# Install Oh My ZSH
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

$(source ~/.bash_profile)
$(source ~/.zshrc)

echo "--> Installing Shiftit"
# Install the window manager
brew cask install shiftit
$(source ~/.bash_profile)
$(source ~/.zshrc)

echo "--> Installing iterm"
# Install Iterm2
if ! [ -e /Applications/iTerm.app ]; then
  wget https://iterm2.com/downloads/stable/iTerm2-3_0_4.zip
  unzip iTerm2-3_0_4.zip
  mv iTerm.app /Applications/
  rm -rf iTerm2-3_0_4.zip
fi

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

echo "--> Ruby: Installing ruby"
$(brew install rbenv ruby-build)
$(echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.bash_profile)
$(echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.zshrc)
$(rbenv install 2.3.1)
$(rbenv global 2.3.1)
$(source ~/.bash_profile)
$(source ~/.zshrc)
echo "---> Ruby version: "
ruby -v

