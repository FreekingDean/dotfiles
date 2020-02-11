#!/bin/bash

####################################
#Install for all configs in Any Platform!
###################################



if [ "$EUID" -eq 0 ]; then
  echo "This script should not be run as root!"
  exit 1
fi

####FUNCTIONS####

PLATFORM=$(uname)
if [ "$PLATFORM" = "linux" ];then
  echo "'$PLATFORM'"
  PLATFORM=$(cat /etc/*-release | grep ^ID=[A-Za-z][A-Za-z]*$ | sed 's/^ID=\(.*\)$/\1/')
  echo "'$PLATFORM'"
  if [ "$PLATFORM" = ""]; then
    if [ -x "$(command -v pacman)" ]; then
      PLATFORM="arch"
    fi
  fi
fi
PACKAGES="zsh ruby git curl wget neovim tmux openssh"

if [ "$PLATFORM" = "debian" ]; then
  PACKAGER="sudo apt-get -y"
  PACKAGER_INSTALL="install"
  PACKAGER_UPDATE="update"
  PACKAGER_UPGRADE="upgrade"
  PACKAGES="$PACKAGES python3 python3-pip libssl-dev libreadline-dev zlib1g-dev"
  sudo cp /usr/bin/pip3 /usr/bin/pip
elif [ "$PLATFORM" = "arch" ]; then
  PACKAGER="sudo pacman --noconfirm"
  PACKAGER_INSTALL="-S"
  PACKAGER_UPDATE="-Syu"
  PACKAGER_UPGRADE="-Syu"
  PACKAGES="$PACKAGES python python-pip"
elif [ "$PLATFORM" = "Darwin" ]; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  PACKAGER="brew"
  PACKAGER_INSTALL="install"
  PACKAGER_UPDATE="update"
  PACKAGER_UPGRADE="upgrade"
  PACKAGES="$PACKAGES python"
else
  echo "platform '$PLATFORM' is not supported"
  exit 1
fi

#Install powerline via git+pip
installPowerline() {
  echo -e "Installing powerline...\n"
  if [ ! -d "$HOME/.powerline" ]; then
    git clone https://github.com/powerline/powerline.git $HOME/.powerline
  fi
  pip install --user --editable=$HOME/.powerline
  if [ ! -f "$HOME/.local/bin/powerline" ]; then
    ln -s $HOME/.powerline/scripts/powerline ~/.local/bin
  fi
}

#Install oh-my-zsh
ohmyzsh() {
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo -e "Installing oh-my-zsh...\n"
    curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
    #in case prompt fails for zsh
  fi
  chsh -s /bin/zsh
}

#git and clone the git file for install
cloneRepo() {
  echo -e "Cloning dotfile repo into directory...\n"
  git clone https://github.com/FreekingDean/dotfiles.git $HOME/.dotfiles
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
  git config --global user.name "Dean Galvin"
  git config --global user.email "deangalvin3@gmail.com"
  #if [ -f $HOME/.ssh/id_rsa.pub ]; then
  #  cat $HOME/.ssh/id_rsa.pub
  #else
  #  ssh-keygen -t rsa -b 4096 -C deangalvin3@gmail.com
  #  cat $HOME/.ssh/id_rsa.pub
  #fi
  #echo -e "Copy the above and enter it here:"
  #echo -e "https://github.com/settings/ssh/new"
  ##read -n 1 -s -r -p "Press any key to continue"
}

installRBENV() {
  if [ ! -d "$HOME/.rbenv" ]; then
    git clone https://github.com/rbenv/rbenv.git ~/.rbenv
    cd ~/.rbenv && src/configure && make -C src || true
  fi
  cd $HOME
  mkdir -p "$(rbenv root)"/plugins
  if [ ! -d "$HOME/.rbenv/plugins/ruby-build" ]; then
    git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
  fi
  ~/.rbenv/bin/rbenv install 2.5.1
}

setupNeoVim() {
  if [ "$PLATFORM" = "arch" ]; then
    echo -e "Installing python-neovim via pacman"
    $PACKAGER $PACKAGER_INSTALL python-neovim
  else
    echo -e "Installing python-neovim via pip"
    sudo pip install neovim
  fi
  mkdir -p $HOME/.config/nvim
  echo "set runtimepath^=~/.vim runtimepath+=~/.vim/after\nlet &packpath = &runtimepath\nsource ~/.vimrc" > ~/.config/nvim/init.vim
  source ~/.zshrc
  mkdir -p $HOME/.vim/tmp $HOME/.vim/backups
  vim +PlugInstall +qall
}

installBasics() {
  mkdir -p $HOME/.bin
  mkdir -p $HOME/.local/bin
  touch $HOME/.secretsrc
  echo -e "Updating then installing zsh wget curl git gvim & tmux...\n"
  $PACKAGER $PACKAGER_UPDATE
  $PACKAGER $PACKAGER_UPGRADE
  $PACKAGER $PACKAGER_INSTALL ${PACKAGES}
  if [ "$PLATFORM" = "debian" ]; then
    sudo update-alternatives --install /usr/bin/python python /usr/bin/python2.7 1
    sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 2
  fi
}

installGems() {
  rbenv shell 2.5.1
  gem install git
  gem install awesome_print
  rbenv shell system
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
