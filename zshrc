# Load modules
autoload -U compinit && compinit
autoload -U colors && colors
setopt prompt_subst


# Setup paths
PATH="$HOME/bin:$PATH"
PATH="/usr/local/bin:/usr/local/sbin:$PATH"
PATH="$HOME/.cabal/bin:$PATH"
# PATH="./bin:$PATH"
# PATH="$HOME/.rbenv/bin:$PATH"
PATH="/usr/local/share/python:$PATH"
PATH="/usr/local/share/npm/bin:$PATH"
export RBENV_ROOT="/usr/local/var/rbenv"
export PYTHONPATH="/usr/local/share/python"
# export NODE_PATH="/usr/local/share/npm/bin"

# Base16 Shell
BASE16_SCHEME="default"
BASE16_SHELL="$HOME/.config/base16-shell/base16-$BASE16_SCHEME"
[[ -s $BASE16_SHELL ]] && . $BASE16_SHELL

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


# export RUBY_MANAGER=detect_ruby_manager()
# function detect-ruby-manager() {
#   ruby-manager=''
#   if [[ -d ~/.rvm ]]; then
#     ruby-manager='rvm'
#   elif [[ -d ~/.rbenv ]]; then 
#     ruby-manager='rbenv'
#   fi

#   echo $ruby-manager
# }

# Controlling Pow
function start_pow() {
  launchctl load ~/Library/LaunchAgents/cx.pow.powd.plist
}

function stop_pow() {
  launchctl unload ~/Library/LaunchAgents/cx.pow.powd.plist
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

function h() {
  if [[ -s $1 ]]; then
    runhaskell $1
  else
    ghci
  fi
}

PROMPT='%{$fg[yellow]%}%m%{$reset_color%}:%U%1~%u ${cmd_status} '
RPROMPT='%{$fg[brblack]%} $(ruby-version) $(~/bin/git-cwd-info.rb)%{$reset_color%}'

# Z
[[ -f `brew --prefix`/etc/profile.d/z.sh ]] && . `brew --prefix`/etc/profile.d/z.sh

# Heroku toolbelt
[[ -d /usr/local/heroku ]] && export PATH="/usr/local/heroku/bin:$PATH"

# Tmux
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

# if [[ -n RBENV_ROOT ]] || [[ -d ~/.rbenv ]]; then
if which rbenv > /dev/null; then
  eval "$(rbenv init -)"
elif [[ -d ~/.rvm ]]; then
  [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
fi
