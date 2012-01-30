setopt promptsubst
autoload -U promptinit
promptinit

PATH="/usr/local/bin:$PATH"
PATH="$HOME/.rbenv/bin:$PATH"

alias git=hub
alias s="git status -sb $argv"
alias d="git diff -M $argv"
alias gdc="git diff --cached -m $argv"
alias gap="git add --all --patch $argv"

parse_git_branch () {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/::\1/' -e '/::master/d'
}

PS1="%1~ $ "
