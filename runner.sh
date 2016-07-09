#!/bin/bash

# Use this to install all the things, its a primary runner

echo 'Welcome to the build runner, we build a custom config for your technical needs'

if ! type brew &> /dev/null; then
  read -p "Do you want to install homebrew?" yn
  if echo "$yn" | grep -iq "^y" ;then
    $(./install_homebrew.sh)
  fi
fi

$(source ~/.bash_profile)

echo "--> Setting up git config"
# Install git config
cp dependencies/.gitconfig ~/

read -p "Do you want to install ZSH?" yn
if echo "$yn" | grep -iq "^y" ;then
  echo "--> Getting oh-my-zsh"
  $(sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)")
fi

$(source ~/.bash_profile)

read -p "Do you want to install window resizer?" yn
if echo "$yn" | grep -iq "^y" ;then
  echo "--> Installing Shiftit"
  # Install the window manager
  brew cask install shiftit
fi

echo "--> Installing iterm"
# Install Iterm2
if ! [ -e /Applications/iTerm.app ]; then
  wget https://iterm2.com/downloads/stable/iTerm2-3_0_4.zip
  unzip iTerm2-3_0_4.zip
  mv iTerm.app /Applications/
  rm -rf iTerm2-3_0_4.zip
fi

read -p "Do you want to config sublime?" yn
if echo "$yn" | grep -iq "^y" ;then
  $(./install_sublime.sh)
fi

read -p "Do you want to install ruby and rails?" yn
if echo "$yn" | grep -iq "^y" ;then
  $(./install_ruby.sh)
fi

read -p "Do you want to install elixir?" yn
if echo "$yn" | grep -iq "^y" ;then
  echo '---> Installing Elixir'
  $(brew install elixir)
  $(source ~/.bash_profile)
fi

read -p "Do you want to install node?" yn
if echo "$yn" | grep -iq "^y" ;then
  echo '---> Installing Node JS'
  $(brew install node)
  $(source ~/.bash_profile)
fi


