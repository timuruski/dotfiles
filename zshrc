# Load modules
autoload -U compinit && compinit
autoload -U colors && colors
setopt prompt_subst

# Setup paths
export GOPATH="$HOME/workspace/go"
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="$GOPATH/bin:$PATH"
export PATH="$HOME/bin:$PATH"

# export CDPATH="$CDPATH:$HOME/workspace/clio:$HOME/workspace"
export BUNDLE_TIMEOUT=30

# Editors
export EDITOR="vim"
export GIT_EDITOR="vim"
set -o emacs

autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# History config
export HISTSIZE=100000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE
setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE INC_APPEND_HISTORY

# FZF
export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_DEFAULT_OPTS="--no-color"

# dev tool https://github.com/clio/dev
# This adds stuff that needs extra configuration, so it's first.
eval "$(dev _hook)"

# Z
[[ -f `brew --prefix`/etc/profile.d/z.sh ]] && . `brew --prefix`/etc/profile.d/z.sh

# Nodenv
eval "$(nodenv init -)"

# Load plugins
for plugin in ~/.zsh/plugins/*.sh; do
  source "$plugin"
done

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
# export PATH="/usr/local/opt/percona-server@5.6/bin:$PATH"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Remove rbenv from PATH, because chruby is better.
export PATH=$(printenv PATH | sed -e "s|$HOME/\.rbenv/shims:||g")

# Load ENV, this is also handled by direnv...
# [[ -f ~/.env ]] && source ~/.env

# Direnv
eval "$(direnv hook zsh)"
