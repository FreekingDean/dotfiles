#! /bin/bash

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
  git clone https://github.com/FreekingDean/dotfiles.git $HOME/.dotfiles
}
####END FUNCTIONS####

#Clone the repo into users home dir
cloneRepo

#Install oh-my-zsh
ohmyzsh

#Install vimrc zshrc and functions
echo -e "Symlinking vimrc, zshrc, tmux.conf and such to HOME...\n"
mv $HOME/.zshrc $HOME/.zshrc.bak #remove original zshrc
mv $HOME/.vimrc $HOME/.vimrc.bak #remove original vimrc
mv $HOME/.tmux $HOME/.tmux.bak #remove original tmux
mv $HOME/.Xresources $HOME/.Xresources.bak #remove original Xresources
mv $HOME/.irssi $HOME/.irssi.bak #remove original irssi

ln -s $HOME/.dotfiles/zshrc $HOME/.zshrc
ln -s $HOME/.dotfiles/tmux.conf $HOME/.tmux.conf
ln -s $HOME/.dotfiles/zsh_aliases $HOME/.zsh_aliases
ln -s $HOME/.dotfiles/vimrc $HOME/.vimrc
ln -s $HOME/.dotfiles/tmux $HOME/.tmux
ln -s $HOME/.dotfiles/Xresources $HOME/.Xresources
ln -s $HOME/.dotfiles/irssi $HOME/.irssi

mkdir -p $HOME/.vim/tmp $HOME/.vim/backups

echo -e "Running basic git configuration...\n"
read -p "Enter your name (full name): " name
read -p "Enter your git email address: " email
git config --global user.name $name
git config --global user.email $email

#Vundle installation and plugin install from vimrc
echo -e "Installing Vundle and running BundleInstall for vim plugins...\n"
git clone https://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle
vim +BundleInstall +qall
