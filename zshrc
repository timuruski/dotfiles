# Load modules
autoload -U compinit && compinit
autoload -U colors && colors
setopt prompt_subst

# Setup paths
PATH="$HOME/bin:$PATH"

# This doesn't work because of a quoting bug.
# $(luarocks path --bin)
PATH="$HOME/.luarocks/bin:$PATH"

export PATH

# export CDPATH="$CDPATH:$HOME/workspace"

export GTYPIST_PATH=$GTYPIST_PATH:$HOME/workspace/gtypist

# Editors
export EDITOR="vim"
export GIT_EDITOR="vim"
set -o emacs
alias learnvim="/usr/bin/env vim -Nu ~/workspace/dotfiles/learn.vim"
alias barevim="vim -Nu ~/.bare.vim"

# fzf
export FZF_DEFAULT_COMMAND='fd --type file --hidden --follow --exclude .git --color=always'
export FZF_DEFAULT_OPTS="--ansi"

autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

export GREP_OPTIONS="--color"

# Base-16 Shell
# source "$HOME/.zsh/base16-shell/scripts/base16-default-light.sh"
# source ~/.zsh/colorscheme.sh
# colorscheme "$HOME/.zsh/base16-shell/base16-ocean.light.sh"
# colorscheme "$HOME/.zsh/base16-shell/base16-default.light.sh"

# BASE16_SHELL=$HOME/.zsh/base16-shell/
# [ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
# base16_default-light

# function invert-colors {
#   case "${BASE16_THEME}" in
#     default-light )
#       base16_default-dark;;
#     default-dark )
#       base16_default-light;;
#   esac
# }

# Define functions and aliases
alias ls="ls -lhG"
alias ag='ag --path-to-ignore ~/.ignore'
alias ql='qlmanage -p "$@" &> /dev/null'
alias be='bundle exec'
alias g='fg'
alias j='jobs'
function fcd() { cd *$1* }

# Workspace shortcut and completion
# function ws() { cd ~/workspace/$1; }
function _ws() { _files -W $HOME/workspace -/; }
compdef _ws ws

# History config
export HISTSIZE=100000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE
setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE

# Z
[[ -f `brew --prefix`/etc/profile.d/z.sh ]] && . `brew --prefix`/etc/profile.d/z.sh

# Direnv
eval "$(direnv hook zsh)"

# Plugins
for plugin in ~/.zsh/plugins/*.sh; do
  source "$plugin"
done

if [[ $ITERM_SESSION_ID ]]; then
  source ~/.zsh/iterm2.sh
fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
