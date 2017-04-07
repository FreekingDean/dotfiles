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
source ~/.zsh_aliases

#oh-my-zsh plugins
plugins=(git github vundle rbenv ruby rails encode64 tmux golang archlinux systemd)

#locale settings
export LANG=en_US.UTF-8


export PATH=$PATH:$GOPATH/bin:$HOME

#export SSL_CERT_FILE='/etc/openssl/cacert.pem'

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

export EDITOR=vim

# added by travis gem
[ -f /Users/deangalvin/.travis/travis.sh ] && source /Users/deangalvin/.travis/travis.sh
export HOMEBREW_GITHUB_API_TOKEN='5f1cf0c40f8650fdd905fe0e80525e3c1dc43675'

#rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="./bin:$PATH"

#Added for cordova
PATH=$PATH:/opt/android-sdk/platform-tools:/opt/android-sdk/tools

#added for gsutil
PATH=$PATH:$HOME/gsutil

[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
if [ "$TERM" = "linux" ]; then
    _SEDCMD='s/.*\*color\([0-9]\{1,\}\).*#\([0-9a-fA-F]\{6\}\).*/\1 \2/p'
    for i in $(sed -n "$_SEDCMD" $HOME/.Xdefaults | \
               awk '$1 < 16 {printf "\\e]P%X%s", $1, $2}'); do
        echo -en "$i"
    done
    clear
fi
export GOPATH=$HOME/go
export CLOUDSDK_PYTHON=/usr/bin/python2

# The next line updates PATH for the Google Cloud SDK.
source '/home/bananaboy/google-cloud-sdk/path.zsh.inc'

# The next line enables bash completion for gcloud.
source '/home/bananaboy/google-cloud-sdk/completion.zsh.inc'
