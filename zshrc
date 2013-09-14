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

#oh-my-zsh plugins
plugins=(git github vundle rbenv ruby rails rails3 encode64 tmux golang archlinux systemd)
