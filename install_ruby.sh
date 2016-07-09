#!/bin/bash

if ! [ -e /Users/adambourg/.rbenv/versions/2.3.1 ]; then
  echo "--> Ruby: Installing ruby"
  $(brew install rbenv ruby-build)
  $(echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.bash_profile)
  $(echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.zshrc)
  $(rbenv install 2.3.1)
  $(rbenv global 2.3.1)
  $(source ~/.bash_profile)
  $(source ~/.zshrc)
fi

echo "---> Ruby version: "
ruby -v

echo '---> Installing rails'
$(gem install rails -v 4.2.6)
$(rbenv rehash)

echo '---> Installing postgres'
$(brew install postgresql)

# To have launchd start postgresql at login:
$(ln -sfv /usr/local/opt/postgresql/*plist ~/Library/LaunchAgents)

# Then to load postgresql now:
$(launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist)
