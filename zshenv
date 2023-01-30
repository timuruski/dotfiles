# #!/bin/zsh

# XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# This is less useful than z, but might be useful for something else.
# export CDPATH="$CDPATH:$HOME/workspace"

export GREP_OPTIONS="--color"

# export GTYPIST_PATH=$GTYPIST_PATH:$HOME/workspace/gtypist
if [ -f /etc/profile ]; then
  PATH=""
  source /etc/profile
fi

# Promote ~/bin
PATH="$HOME/bin:$PATH"

# This doesn't work because of a quoting bug.
# $(luarocks path --bin)
PATH="$HOME/.luarocks/bin:$PATH"

# Postgres
PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"

# PATH="$HOME/Library/Python/3.9/bin:$PATH"

# Editor
export EDITOR="nvim"
export GIT_EDITOR="nvim"

# Vim
export VIMCONFIG=~/.config/nvim
export VIMDATA=~/.local/share/nvim
export THOR_MERGE=vimdiff

# fzf https://github.com/junegunn/fzf
export FZF_DEFAULT_COMMAND='fd --type file --hidden --follow --exclude .git --exclude .keep'
export FZF_DEFAULT_OPTS="--ansi --no-color"

# Command history
export HISTFILE="$ZDOTDIR/.zhistory"
export HISTSIZE=10000
export SAVEHIST=10000
