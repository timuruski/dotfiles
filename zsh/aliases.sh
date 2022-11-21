# Do I still need these?
alias learnvim="/usr/bin/env vim -Nu ~/workspace/dotfiles/learn.vim"
alias barevim="vim -Nu ~/.bare.vim"

# Define functions and aliases
alias ag="ag --path-to-ignore ~/.ignore"
alias b="battery-info"
alias bx="bundle exec"
alias dx="docker compose"
alias fd="fd --color=never"
alias ls="ls -lhG"
alias ql="qlmanage -p "$@" &> /dev/null"
alias vi="nvim"

# Aliases to make up for escape key twitch
alias dit="edit"
alias g="fg"
alias it="git"
alias obs="jobs"

# Ignore test files when searching
alias rrg="rg --ignore-file ~/.ignore --ignore-file ~/.ignore-tests"
alias rgg="rg --ignore-file ~/.ignore --ignore-file ~/.ignore-tests"
alias rrrg="rg --ignore-file ~/.ignore --ignore-file ~/.just-tests"
alias rggg="rg --ignore-file ~/.ignore --ignore-file ~/.just-tests"
alias fdd="fd --ignore-file ~/.ignore --ignore-file ~/.ignore-tests"
alias ffd="fd --ignore-file ~/.ignore --ignore-file ~/.ignore-tests"
alias fddd="fd --ignore-file ~/.ignore --ignore-file ~/.just-tests"
alias fffd="fd --ignore-file ~/.ignore --ignore-file ~/.just-tests"

# Local bundler stuff
# alias lbundle="bundler config --local local true"
# alias rbundle="bundle config unset local"
# alias lbundle="bundle config gemfile Gemfile.local"
# alias rbundle="bundle config unset gemfile"
# alias lbundle="export BUNDLE_GEMFILE=Gemfile.local"
# alias rbundle="unset BUNDLE_GEMFILE"
alias lbundle="export BUNDLE_GEMFILE=Gemfile.local && bundle config gemfile Gemfile.local"
alias rbundle="unset BUNDLE_GEMFILE && bundle config unset gemfile"
