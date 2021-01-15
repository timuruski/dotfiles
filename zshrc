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

# export CDPATH="$CDPATH:$HOME/workspace/clio:$HOME/workspace"
export BUNDLE_TIMEOUT=30

# Editors
export EDITOR="vim"
export GIT_EDITOR="vim"
set -o emacs
alias learnvim="/usr/bin/env vim -Nu ~/.learnvimrc"
alias barevim="/usr/bin/env vim -Nu ~/.dotfiles/.minimal-vimrc"

# FZF
export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_DEFAULT_OPTS="--no-color"

autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# REPLACED by iTerm 2 color system
# Base-16 Shell
# source ~/.zsh/colorscheme.sh
# colorscheme "$HOME/.zsh/base16-shell/base16-default.light.sh"

# Define functions and aliases
alias bx="bundle exec"
alias dx="docker-compose exec"
alias ffg="fg"
alias fgg="fg"
alias g="fg"
alias i="vi"
alias it="git"
alias ls="ls -lhG"
alias obs="jobs"
alias ql="qlmanage -p "$@" &> /dev/null"
alias tree="tree -I 'node_modules|vendor'"
alias untar="tar -xvf"
alias vi="vim"
alias xit="exit"

# Ignore test files when searching
alias rrg="rg --ignore-file ~/.ignore --ignore-file ~/.ignore-tests"
alias rgg="rg --ignore-file ~/.ignore --ignore-file ~/.ignore-tests"
alias ffd="fd --ignore-file ~/.ignore-tests"
alias fdd="fd --ignore-file ~/.ignore-tests"

# function glow() {
#   /usr/bin/env glow $@ --style=light --pager
# }

function vv() {
  # if [ $yes_vim -eq 0 ]; then
  if jobs | egrep -q "\b(vv|vim?)\b"; then
    fg
  else
    vim $@
  fi
}

alias show_path="ruby -e \"puts ENV['PATH'].split(':')\""
function mcd() { mkdir -p $1 && cd $1 }
function fcd() { cd *$1* }
# function tag() {  }

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

# Nodenv
eval "$(nodenv init -)"

# thefuck https://github.com/nvbn/thefuck
eval $(thefuck --alias ff)

# Plugins
for plugin in ~/.zsh/plugins/*.sh; do
  source "$plugin"
done

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
# export PATH="/usr/local/opt/percona-server@5.6/bin:$PATH"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
