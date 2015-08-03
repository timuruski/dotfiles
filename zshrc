# Load modules
autoload -U compinit && compinit
autoload -U colors && colors
setopt prompt_subst


# Setup paths
export GOPATH="$HOME/go"
PATH="$GOPATH/bin:$PATH"

PATH="$HOME/bin:$PATH"
PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH

# Editors
export EDITOR="vim"
export GIT_EDITOR="vim"
set -o emacs
alias barevim="/usr/binvi -Nu ~/.barevim"

autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# Define functions and aliases
alias ls="ls -lhG"
alias e="vim"
alias be="bundle exec"
function mkcd() { mkdir -p $1 && cd $1 }
function fcd() { cd *$1* }

# Workspace shortcut and completion
function ws() { cd ~/workspace/$1; }
function _ws() { _files -W ~/workspace -/; }
compdef _ws ws
alias dot="cd ~/workspace/dotfiles"

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
local cmd_status="%(?,%{$reset_color%}$%{$reset_color%},%{$fg[red]%}$%{$reset_color%})"
parse_git_branch () {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/::\1/' -e '/::master/d'
}

function ruby-version() {
  /usr/bin/env ruby -v | cut -d ' ' -f 2
}

function host_color() {
  [[ -n "$TMUX" ]] && printf 'blue' || printf 'green'
}

function tmux_info() {
  [[ -z "$TMUX" ]] && return

  info=$(tmux list-windows -F '#{?window_active,[#{window_index}/#{session_windows}],}' | awk '!/^$/')
  printf "$info "
}

function tmux_info2() {
  [[ -z "$TMUX" ]] && return

  info=$(tmux list-windows -F '#{?window_active,#,.}' | awk '{ printf $1 }')
  printf "$info "
}

# PROMPT='%{$fg[green]%}%m%{$reset_color%}:%U%1~%u ${cmd_status} '
PROMPT='$(tmux_info2)%{$fg[$(host_color)]%}%m%{$reset_color%}:%U%1~%u ${cmd_status} '
RPROMPT='%{$fg[brblack]%} $(~/bin/git-cwd-info.rb)%{$reset_color%}'

# Z
[[ -f `brew --prefix`/etc/profile.d/z.sh ]] && . `brew --prefix`/etc/profile.d/z.sh

# Heroku toolbelt
[[ -d /usr/local/heroku ]] && export PATH="/usr/local/heroku/bin:$PATH"
