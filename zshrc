# Load modules
autoload -U compinit && compinit
autoload -U colors && colors
setopt prompt_subst


# Setup paths
export GOPATH="$HOME/workspace/go"
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="$GOPATH/bin:$PATH"
export PATH="$HOME/bin:$PATH"
[[ -d /usr/local/heroku ]] && PATH="/usr/local/heroku/bin:$PATH"

export CDPATH="$CDPATH:$HOME/workspace/clio:$HOME/workspace"

# Editors
export EDITOR="vim"
export GIT_EDITOR="vim"
set -o emacs
alias learnvim="/usr/bin/env vim -Nu ~/.learnvimrc"
alias barevim="/usr/bin/env vim -Nu ~/.dotfiles/.minimal-vimrc"

# FZF
export FZF_DEFAULT_COMMAND='ag -g ""'

autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# Base-16 Shell
source ~/.zsh/colorscheme.sh
colorscheme "$HOME/.zsh/base16-shell/base16-ocean.light.sh"
# colorscheme "$HOME/.zsh/base16-shell/scripts/base16-tomorrow.sh"

# Define functions and aliases
alias vi="vim"
alias ls="ls -lhG"
alias tree="tree -I 'node_modules|vendor'"
alias ql='qlmanage -p "$@" &> /dev/null'
alias b='bundle exec'
alias g='fg'
alias obs='jobs'
alias i='vi'
alias aag='ag --ignore spec --ignore test'
alias show_path="ruby -e \"puts ENV['PATH'].split(':')\""
function mkcd() { mkdir -p $1 && cd $1 }
function fcd() { cd *$1* }

# Workspace shortcut and completion
function ws() { cd ~/workspace/$1; }
function _ws() { _files -W ~/workspace -/; }
compdef _ws ws

# History config
export HISTSIZE=100000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE
setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE INC_APPEND_HISTORY

# Datastore services
source $HOME/.zsh/postgres.sh
source $HOME/.zsh/mongo.sh
source $HOME/.zsh/redis.sh

# Z
[[ -f `brew --prefix`/etc/profile.d/z.sh ]] && . `brew --prefix`/etc/profile.d/z.sh

# Direnv
eval "$(direnv hook zsh)"

# Plugins
for plugin in ~/.zsh/plugins/*.sh; do
  source "$plugin"
done

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
# export PATH="/usr/local/opt/percona-server@5.6/bin:$PATH"
