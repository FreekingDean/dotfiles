#!/bin/bash

current=`rbenv local`
eval "$(rbenv init -)"
rbenv shell system
ruby $HOME/.dotfiles/helper_scripts/dotfiles_sync.rb
rbenv shell $current
