# Load modules
autoload -U compinit && compinit
autoload -U colors && colors
setopt prompt_subst


# Setup paths
PATH="$PATH:~/bin"
PATH="/usr/local/bin:$PATH"
PATH="$HOME/.rbenv/bin:$PATH"


# Editors
export EDITOR="vim"
export GIT_EDITOR="vim -c 'startinsert'"


# Define functions and aliases
alias ls="ls -lh"
function mkcd() { mkdir -p $1 && cd $1 }
function fcd() { cd *$1* }
# Git aliases
alias git=hub
alias s="git status -sb $argv; return 0"
alias d="git diff -M"
alias ga="git add"
alias gaa="git add --all"
alias gco="git checkout"
alias gci="git commit"
alias gdc="git diff --cached -m"
alias gap="git add --all --patch"
alias gfo="git fetch origin"
alias gpff="git pull --ff-only"
alias gprb="git pull --rebase"
alias gpom="git push origin master"
alias gl="git log"
alias gld="git log --simplify-by-decoration"


# Customize prompt
local cmd_status="%(?,%{$reset_color%}$%{$reset_color%},%{$fg[red]%}$%{$reset_color%})"
parse_git_branch () {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/::\1/' -e '/::master/d'
}
function ruby-version() {
  echo "$(rbenv version-name)"
}

PROMPT='%1~ ${cmd_status} '
RPROMPT='%{$fg[white]%} $(ruby-version) $(~/bin/git-cwd-info.rb)%{$reset_color%}'

# Tmux
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator
# Initialize rbenv, cos RVM is busted
eval "$(rbenv init -)"

