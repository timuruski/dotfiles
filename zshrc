# Load modules
autoload -U compinit && compinit
autoload -U colors && colors
setopt prompt_subst

# Setup paths
PATH="/usr/local/bin:/usr/local/sbin:$PATH"
PATH="/usr/local/share/npm/bin:$PATH"
[[ -d /usr/local/heroku ]] && export PATH="/usr/local/heroku/bin:$PATH"
PATH="$HOME/bin:$PATH"

export PATH

export EDITOR="vim"
export GIT_EDITOR="vim"
set -o emacs
alias barevim="/usr/binvi -Nu ~/.barevim"

autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# Define functions and aliases
alias ls="ls -lhG"
alias ql='qlmanage -p "$@" &> /dev/null'
alias be='bundle exec'
function mkcd() { mkdir -p $1 && cd $1 }
function fcd() { cd *$1* }

# PetroFeed application environments
alias on_api="HEROKU_APP=petrofeed-api heroku"
alias on_api_preprod="HEROKU_APP=preprod-api-petrofeed heroku"
alias on_api_dev="HEROKU_APP=dev-api-petrofeed heroku"
alias on_docs="HEROKU_APP=acquisition-petrofeed heroku"
alias on_docs_preprod="HEROKU_APP=acquisition-petrofeed-preprod heroku"
alias on_docs_dev="HEROKU_APP=acquisition-petrofeed-dev heroku"

# Local application workspaces
alias start-api="workspace-start platform-apis"
alias stop-api="workspace-stop platform-apis"
alias start-docs="workspace-start ingestion"
alias stop-docs="workspace-stop ingestion"
alias start-connect="workspace-start connect"
alias stop-connect="workspace-stop connect"

# Workspace shortcut and completion
function ws() { cd ~/workspace/$1; }
function _ws() { _files -W ~/workspace -/; }
compdef _ws ws
alias dot="cd ~/workspace/dotfiles"

# Controlling PostgreSQL
function start_psql() {
  launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
}

function stop_psql() {
  launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
}


# Deep history
export HISTSIZE=100000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE
setopt HIST_IGNORE_DUPS


# Customize prompt
local cmd_status="%(?,%{$reset_color%},%{$fg[red]%})♥%{$reset_color%}"
parse_git_branch () {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/::\1/' -e '/::master/d'
}

PROMPT=' ${cmd_status} %{$fg[blue]%}%m%{$reset_color%}:%U%1~%u '
RPROMPT='%{$fg[brblack]%}$(~/bin/git-cwd-info.rb)%{$reset_color%}'

# Z
[[ -f `brew --prefix`/etc/profile.d/z.sh ]] && . `brew --prefix`/etc/profile.d/z.sh

# Plugins
for plugin in ~/.zsh/plugins/*.sh; do
  source "$plugin"
done
