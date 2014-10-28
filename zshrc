# Load modules
autoload -U compinit && compinit
autoload -U colors && colors
setopt prompt_subst


# Setup paths
PATH="$HOME/bin:$PATH"
PATH="/usr/local/bin:/usr/local/sbin:$PATH"
PATH="/usr/local/share/python:$PATH"
PATH="/usr/local/share/npm/bin:$PATH"
export RBENV_ROOT="/usr/local/var/rbenv"
export PYTHONPATH="/usr/local/share/python"
# export NODE_PATH="/usr/local/share/npm/bin"

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
alias preprod='HEROKU_APP=preprod-api-petrofeed heroku'
alias prod='HEROKU_APP=petrofeed-api heroku'

# Workspace shortcut and completion
function ws() { cd ~/workspace/$1; }
function _ws() { _files -W ~/workspace -/; }
compdef _ws ws
alias dot="cd ~/workspace/dotfiles"

# Deep history
export HISTSIZE=100000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE
setopt HIST_IGNORE_DUPS


# Customize prompt
local cmd_status="%(?,%{$reset_color%}$%{$reset_color%},%{$fg[red]%}$%{$reset_color%})"
parse_git_branch () {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/::\1/' -e '/::master/d'
}

# Controlling PostgreSQL
function start_psql() {
  launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
}

function stop_psql() {
  launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
}

function ruby-version() {
  # if [[ -d ~/.rbenv ]]; then
  if which rbenv > /dev/null; then
    echo "$(rbenv version-name)"
  elif [[ -d ~/.rvm ]]; then
    echo "$(~/.rvm/bin/rvm-prompt)"
  fi
}

PROMPT='%{$fg[blue]%}%m%{$reset_color%}:%U%1~%u ${cmd_status} '
RPROMPT='%{$fg[brblack]%} $(ruby-version) $(~/bin/git-cwd-info.rb)%{$reset_color%}'

# Use boxen
source /opt/boxen/env.sh

# Heroku toolbelt
[[ -d /usr/local/heroku ]] && export PATH="/usr/local/heroku/bin:$PATH"

# Z
[[ -f `brew --prefix`/etc/profile.d/z.sh ]] && . `brew --prefix`/etc/profile.d/z.sh
