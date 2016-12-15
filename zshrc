# Load modules
autoload -U compinit && compinit
autoload -U colors && colors
setopt prompt_subst


# Setup paths
export GOPATH="$HOME/go"
PATH="$GOPATH/bin:$PATH"
PATH="/usr/local/bin:/usr/local/sbin:$PATH"
PATH="$HOME/bin:$PATH"
[[ -d /usr/local/heroku ]] && PATH="/usr/local/heroku/bin:$PATH"

export PATH

# Editors
export EDITOR="vim"
export GIT_EDITOR="vim"
set -o emacs
alias learnvim="/usr/bin/env vim -Nu ~/.learnvimrc"

autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# Base-16 Shell
source ~/.zsh/colorscheme.sh
colorscheme "$HOME/.zsh/base16-shell/base16-ocean.light.sh"

# Define functions and aliases
alias ls="ls -lhG"
alias ql='qlmanage -p "$@" &> /dev/null'
alias be='bundle exec'
alias g='fg'
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
setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE

# Datastore services
source $HOME/.zsh/postgres.sh
source $HOME/.zsh/mongo.sh
source $HOME/.zsh/redis.sh


# Customize prompt
local cmd_status="%(?,%{$reset_color%},%{$fg[red]%})♥%{$reset_color%}"
parse_git_branch () {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/::\1/' -e '/::master/d'
}

PROMPT=' ${cmd_status} %{$fg[blue]%}%m%{$reset_color%}:%U%1~%u '
RPROMPT='%{$fg[brblack]%}$(~/bin/git-cwd-info.rb)%{$reset_color%}'

# Z
[[ -f `brew --prefix`/etc/profile.d/z.sh ]] && . `brew --prefix`/etc/profile.d/z.sh

# Direnv
eval "$(direnv hook zsh)"

# Plugins
for plugin in ~/.zsh/plugins/*.sh; do
  source "$plugin"
done

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
