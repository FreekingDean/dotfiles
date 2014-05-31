#oh-my-zsh
ZSH=$HOME/.oh-my-zsh
DEFAULT_USER="bananaboy"
ZSH_THEME="clean"
# (random) clean miloshadzic takashiyoshida sporty_256 sorin robbyrussell nicoulaj
source $ZSH/oh-my-zsh.sh
export TERM=xterm-256color #fix so tmux colors, and vim colors all play nice
# tmux on start with zsh
if [ "$TMUX" = "" ]; then tmux; fi

#Aliases
alias irssi="TERM=screen-256color irssi" #fix for the xterm fix above with xfce4term and irssi buffer
alias trash="mv --target-directory=$HOME/.Trash"

#oh-my-zsh plugins
plugins=(git github vundle rbenv ruby rails rails3 encode64 tmux golang archlinux systemd)

#locale settings
export LANG=en_US.UTF-8

export GOPATH=$HOME/go

export PATH=$PATH:$GOPATH/bin:$HOME

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
