# Load modules
autoload -U compinit && compinit
autoload -U colors && colors
setopt prompt_subst


# Setup paths
PATH="$PATH:~/bin"
PATH="/usr/local/bin:/usr/local/sbin:$PATH"
PATH="$HOME/.rbenv/bin:$PATH"


# Editors
export EDITOR="vim"
# export GIT_EDITOR="vim -c 'startinsert'"
GIT_EDITOR="vim"


# Define functions and aliases
alias ls="ls -lh"
alias r="rails"
function mkcd() { mkdir -p $1 && cd $1 }
function fcd() { cd *$1* }

# Workspace shortcut and completion
function ws() { cd ~/workspace/$1; }
function _ws() { _files -W ~/workspace -/; }
compdef _ws ws
alias dot="cd ~/workspace/dotfiles"

# Git aliases
alias git=hub
alias s="git status -sb"
alias d="git d"
alias gap="git p"

# Deep history
export HISTSIZE=100000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE


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

function ruby-version() {
  if [[ -d ~/.rbenv ]]; then 
    echo "$(rbenv version-name)"
  elif [[ -d ~/.rvm ]]; then
    echo "$(~/.rvm/bin/rvm-prompt)"
  fi
}

PROMPT='%{$fg[yellow]%}%m%{$reset_color%}:%U%1~%u ${cmd_status} '
RPROMPT='%{$fg[brblack]%} $(ruby-version) $(~/bin/git-cwd-info.rb)%{$reset_color%}'

# Tmux
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

if [[ -d ~/.rbenv ]]; then 
  eval "$(rbenv init -)"
elif [[ -d ~/.rvm ]]; then
  [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
fi
