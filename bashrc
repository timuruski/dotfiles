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
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/::\1/' -e '/::master/d'
}
alias revspec="run-command-on-git-revisions origin/master master 'rspec spec'"

# ----------------------------------------------------------------------
# TODO
# ----------------------------------------------------------------------
alias t="python ~/vendor/t/t.py --task-dir ~/Dropbox/tasks --list todo"
alias i="python ~/vendor/t/t.py --task-dir ~/Dropbox/tasks --list ideas"

# ----------------------------------------------------------------------
# PROMPT, ETC.
# ----------------------------------------------------------------------
job_marker () {
  # . ∶ ∴ ∷ 
  jobs | wc -l | awk '{ if($1 != "0") print "\033[32m*\033[0m " }'
}
todo_count () {
  t | wc -l | awk '{ if($1 != "0") print "\033[4m" $1 "\033[0m " }'
}

PS1="\$(job_marker)\$(todo_count)\e[0m\W\$(parse_git_branch) \$ "

# growl() { echo -e $'\e]9;'${1}'\007' ; return  ; }
alias ls="ls -lh"

# ----------------------------------------------------------------------
# RUBY
# ----------------------------------------------------------------------
# export RUBYOPT="rubygems"
export RACK_ENV='development'

if [[ -d ~/.rbenv ]]; then 
  eval "$(rbenv init -)"
elif [[ -d ~/.rvm ]]; then
  [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
fi

#EOF .bashrc
