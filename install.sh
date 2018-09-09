#!/bin/bash

####################################
#Install for all configs in Any Platform!
####################################

if [ "$EUID" -eq 0 ]; then
  echo "This script should not be run as root!"
  exit 1
fi

####FUNCTIONS####

PLATFORM=$(cat /etc/*-release | grep ^ID=[A-Za-z][A-Za-z]*$ | sed 's/^ID=\(.*\)$/\1/')
PACKAGES="zsh ruby git curl wget neovim tmux"

if [ "$PLATFORM" = "debian" ]; then
  PACKAGER="apt-get -y"
  PACKAGER_INSTALL="install"
  PACKAGER_UPDATE="update"
  PACKAGER_UPGRADE="upgrade"
  PACKAGES="$PACKAGES python3 python3-pip libssl-dev libreadline-dev zlib1g-dev"
  sudo cp /usr/bin/pip3 /usr/bin/pip
elif [ "$PLATFORM" = "arch" ]; then
  PACKAGER="pacman --noconfirm"
  PACKAGER_INSTALL="-S"
  PACKAGER_UPDATE="-Syu"
  PACKAGER_UPGRADE="-Syu"
  PACKAGES="$PACKAGES python python-pip"
else
  echo "platform '$PLATFORM' is not supported"
fi

#Install powerline via git+pip
installPowerline() {
  echo -e "Installing powerline...\n"
  git clone https://github.com/powerline/powerline.git $HOME/.powerline
  pip install --user --editable=$HOME/.powerline
  #ln -s $HOME/.powerline/scripts/powerline ~/.local/bin
}

#Install oh-my-zsh
ohmyzsh() {
  echo -e "Installing oh-my-zsh...\n"
  curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
  #in case prompt fails for zsh
  chsh -s /bin/zsh
}

#git and clone the git file for install
cloneRepo() {
  echo -e "Cloning dotfile repo into directory...\n"
  git clone git@github.com:FreekingDean/dotfiles.git $HOME/.dotfiles
  echo -e "Symlinking vimrc, zshrc, tmux.conf and such to HOME...\n"
  mv $HOME/.zshrc $HOME/.zshrc.bak #remove original zshrc

  ln -s $HOME/.dotfiles/zshrc $HOME/.zshrc
  ln -s $HOME/.dotfiles/tmux.conf $HOME/.tmux.conf
  ln -s $HOME/.dotfiles/zsh_aliases $HOME/.zsh_aliases
  ln -s $HOME/.dotfiles/vimrc $HOME/.vimrc
  ln -s $HOME/.dotfiles/tmux $HOME/.tmux
  ln -s $HOME/.dotfiles/Xresources $HOME/.Xresources
  ln -s $HOME/.dotfiles/irssi $HOME/.irssi
  ln -s $HOME/.dotfiles/khdrc $HOME/.khdrc
  ln -s $HOME/.dotfiles/chunkwmrc $HOME/.chunkwmrc
}

#setup git
setupGit() {
  echo -e "Running basic git configuration...\n"
  read -p "Enter your name (full name): " name
  read -p "Enter your git email address: " email
  git config --global user.name $name
  git config --global user.email $email
  if [ -f $HOME/.ssh/id_rsa.pub ]; then
    cat $HOME/.ssh/id_rsa.pub
  else
    ssh-keygen -t rsa -b 4096 -C $email
    cat $HOME/.ssh/id_rsa.pub
  fi
  echo -e "Copy the above and enter it here:"
  echo -e "https://github.com/settings/ssh/new"
  read -n 1 -s -r -p "Press any key to continue"
}

installRBENV() {
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  cd ~/.rbenv && src/configure && make -C src || true
  cd $HOME
  mkdir -p "$(rbenv root)"/plugins
  git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
  ~/.rbenv/bin/rbenv install 2.5.1
}

setupNeoVim() {
  if [ "$PLATFORM" = "debian" ]; then
    echo -e "Installing python-neovim via pip"
    sudo pip install python-neovim
  elif [ "$PLATFORM" = "arch" ]; then
    echo -e "Installing python-neovim via pacman"
    sudo pacman -S python-neovim
  fi
  mkdir -p $HOME/.config/nvim
  echo -e "set runtimepath^=~/.vim runtimepath+=~/.vim/after\nlet &packpath = &runtimepath\nsource ~/.vimrc" > ~/.config/nvim/init.vim
  mkdir -p $HOME/.vim/tmp $HOME/.vim/backups
  vim +PlugInstall +qall
}

installBasics() {
  mkdir -p $HOME/.bin
  mkdir -p $HOME/.local/bin
  touch $HOME/.secretsrc
  echo -e "Updating then installing zsh wget curl git gvim & tmux...\n"
  sudo $PACKAGER $PACKAGER_UPDATE
  sudo $PACKAGER $PACKAGER_UPGRADE
  sudo $PACKAGER $PACKAGER_INSTALL ${PACKAGES}
  if [ "$PLATFORM" = "debian" ]; then
    sudo update-alternatives --install /usr/bin/python python /usr/bin/python2.7 1
    sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 2
  fi
}

installGems() {
  ~/.rbenv/bin/rbenv shell 2.5.1
  gem install git
  gem install awesome_print
  ~/.rbenv/bin/rbenv shell system
}

####END FUNCTIONS####

echo -e "PREPARE YOUR COMPUTER FOR SOME MOFUCKIN DOTS."

installBasics
setupGit
cloneRepo
ohmyzsh
installRBENV
setupNeoVim
installPowerline
installGems
