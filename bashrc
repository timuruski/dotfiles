# ----------------------------------------------------------------------
# PATH
# ----------------------------------------------------------------------
PATH="/usr/local/bin:$PATH"
test -d "$HOME/.bin" && PATH="$HOME/.bin:$PATH"
test -d "$HOME/bin" && PATH="$HOME/bin:$PATH"
# export NODE_PATH="/usr/local/lib/node:/usr/local/lib/node_modules"

# TOOLS
export GREP_OPTIONS="--color"

# ----------------------------------------------------------------------
# EDITOR
# ----------------------------------------------------------------------
export EDITOR='vi'
# export EDITOR='mvim -f -c "au VimLeave * !open -a Terminal"'


# ----------------------------------------------------------------------
# COMPLETION
# ----------------------------------------------------------------------
if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
  source ~/.git-completion.sh
fi


# ----------------------------------------------------------------------
# GIT
# ----------------------------------------------------------------------
parse_git_branch () {
  git rev-parse --abbrev-ref HEAD

}
alias git=hub
alias g=git
alias gp="git add --all --patch"
alias gst="git status"
alias s="git status -sb $argv"
alias d="git diff -M $argv"
alias gh="git help"
alias revspec="run-command-on-git-revisions origin/master master 'rspec spec'"

# ----------------------------------------------------------------------
# PROMPT, ETC.
# ----------------------------------------------------------------------
PS1="$(parse_git_branch) \W \$ "

alias ls="ls -lh"

export RACK_ENV='development'

if [[ -e /opt/homebrew/opt/chruby/share/chruby/chruby.sh ]]; then
  source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
fi

#EOF .bashrc
