#oh-my-zsh
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="clean"

# (random) clean miloshadzic takashiyoshida sporty_256 sorin robbyrussell nicoulaj
source $ZSH/oh-my-zsh.sh

export TERM=xterm-256color #fix so tmux colors, and vim colors all play nice

# tmux on start with zsh
# if [ "$TMUX" = "" ]; then tmux; fi

#Aliases
source ~/.zsh_aliases

#oh-my-zsh plugins
plugins=(git github vundle rbenv ruby rails encode64 tmux golang)

#locale settings
export LANG=en_US.UTF-8

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin:$HOME

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

export EDITOR=nvim

# added by travis gem
[ -f /Users/$USER/.travis/travis.sh ] && source /Users/$USER/.travis/travis.sh

#brew
export PATH="/usr/local/opt/python/libexec/bin:/usr/local/bin:/usr/local/sbin:$PATH"

#rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="./bin:$PATH"

#Added for cordova
PATH=$PATH:/opt/android-sdk/platform-tools:/opt/android-sdk/tools

#added for gsutil
PATH=$PATH:$HOME/gsutil

#added for additional data
PATH=$PATH:$HOME/.bin:$HOME/.local/bin:$HOME/.bin/pact/bin

[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
#if [ "$TERM" = "linux" ]; then
#    _SEDCMD='s/.*\*color\([0-9]\{1,\}\).*#\([0-9a-fA-F]\{6\}\).*/\1 \2/p'
#    for i in $(sed -n "$_SEDCMD" $HOME/.Xdefaults | \
#               awk '$1 < 16 {printf "\\e]P%X%s", $1, $2}'); do
#        echo -en "$i"
#    done
#    clear
#fi
#export CLOUDSDK_PYTHON=/usr/bin/python2

# The next line updates PATH for the Google Cloud SDK.
# source '/home/$USER/google-cloud-sdk/path.zsh.inc'

# The next line enables bash completion for gcloud.
# source '/home/$USER/google-cloud-sdk/completion.zsh.inc'

if [[ "$SKIP_DEV_ENV_UPDATE" != "true" ]]; then
  update_dev_env
fi

ANDROID_HOME=$HOME/Android/Sdk

source ~/.secretsrc

source ~/.dotfiles/platform_loader
export PATH="/usr/local/opt/node@8/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/deangalvin/Projects/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/deangalvin/Projects/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/deangalvin/Projects/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/deangalvin/Projects/google-cloud-sdk/completion.zsh.inc'; fi
export POWERLINE_CONFIG_COMMAND=$HOME/.powerline/scripts/powerline-config

source <(kubectl completion zsh)

. $HOME/.asdf/asdf.sh

. $HOME/.asdf/completions/asdf.bash
