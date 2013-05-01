#oh-my-zsh
ZSH=$HOME/.oh-my-zsh
DEFAULT_USER="jake"
ZSH_THEME="clean"
# (random) clean miloshadzic takashiyoshida sporty_256 sorin robbyrussell nicoulaj
source $ZSH/oh-my-zsh.sh
export TERM=xterm-256color #fix so tmux colors, and vim colors all play nice
# tmux on start with zsh
if [ "$TMUX" = "" ]; then tmux; fi

#Aliases
alias gob="go build"
alias git="hub"
alias sudo="nocorrect sudo"
alias irssi="TERM=screen-256color irssi" #fix for the xterm fix above with xfce4term and irssi buffer

# Suffix Aliases - open filetypes with program of choice
alias -s html=gvim
alias -s css=gvim
alias -s js=gvim
alias -s php=gvim
alias -s erb=gvim
alias -s c=gvim
alias -s cpp=gvim
alias -s go=gvim

#oh-my-zsh plugins
plugins=(git github vundle rbenv ruby rails rails3 encode64 tmux golang archlinux systemd)

# Miscellaneous functions
source $HOME/.zsh_aliases

export PATH="$HOME/.rbenv/bin:$PATH"

# RBENV
eval "$(rbenv init -)"
