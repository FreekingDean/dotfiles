#!/bin/bash

current=`rbenv local`
eval "$(rbenv init -)"
rbenv shell 2.5.1
ruby $HOME/.dotfiles/helper_scripts/dotfiles_sync.rb "$@"
rbenv shell $current
