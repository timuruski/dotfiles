# Load modules
autoload -U compinit && compinit
autoload -U colors && colors
setopt prompt_subst

# Setup paths
PATH="/usr/local/bin:/usr/local/sbin:$PATH"
PATH="/usr/local/share/npm/bin:$PATH"
PATH=$PATH:/usr/local/opt/go/libexec/bin
[[ -d /usr/local/heroku ]] && export PATH="/usr/local/heroku/bin:$PATH"
PATH="$HOME/bin:$PATH"

if which nodenv > /dev/null; then eval "$(nodenv init -)"; fi

export PATH

# Setup editors
export EDITOR="vim"
export GIT_EDITOR="vim"
export CPUS=1
set -o emacs
alias barevim="/usr/binvi -Nu ~/.barevim"

autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# Base-16 Shell
source ~/.zsh/colorscheme.sh
[[ -n "$COLORSCHEME" ]] || colorscheme "$HOME/.zsh/base16-shell/base16-eighties.light.sh"

# Define functions and aliases
alias ls="ls -lhG"
alias ql='qlmanage -p "$@" &> /dev/null'
alias be='bundle exec'
alias ne='PATH=./node_modules/.bin:$PATH'
alias npmw='./npmw'
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
local cmd_status="%(?,%{$reset_color%},%{$fg[red]%})♥%{$reset_color%}"
parse_git_branch () {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/::\1/' -e '/::master/d'
}

PROMPT=' ${cmd_status} %{$fg[blue]%}%m%{$reset_color%}:%U%1~%u '
RPROMPT='%{$fg[brblack]%}$(~/bin/git-cwd-info.rb)%{$reset_color%}'

# Z
[[ -f `brew --prefix`/etc/profile.d/z.sh ]] && . `brew --prefix`/etc/profile.d/z.sh

# Controlling data stores
source ~/.zsh/postgres.sh
source ~/.zsh/mongo.sh
source ~/.zsh/redis.sh

# Plugins
for plugin in ~/.zsh/plugins/*.sh; do
  source "$plugin"
done
