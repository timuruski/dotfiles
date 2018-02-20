## PROMPT
status () {
  if [[ $? -gt 0 ]]; then
    printf "\e[31m$\e[0m"
  else
    printf "$"
  fi
}

PS1="\e[2K\e[33m\h\e[0m:\e[4m\W\e[0m \$(status) "

# CHRUBY
source /usr/local/share/chruby/chruby.sh
# source /usr/local/share/chruby/auto.sh
# chruby 2.4

## DIRENV
eval "$(direnv hook bash)"

# HACK to fix direnv integration with bash --login
# bash --login <(echo 'which bundle')
# /Users/timuruski/workspace/themis/.direnv/bin
# /Users/timuruski/workspace/themis/.direnv/ruby/bin
# /Users/timuruski/.rubies/ruby-2.3.5/bin
# /Users/timuruski/.gem/ruby/2.3.5/bin
# /Users/timuruski/.rubies/ruby-2.3.5/lib/ruby/gems/2.3.0/bin
# /Users/timuruski/.rubies/ruby-2.3.5/bin
if [[ $(pwd) = "$HOME/workspace/themis" ]]; then
  # chruby $(cat .ruby-version)
  export PATH="$HOME/workspace/themis/.direnv/bin:$HOME/workspace/themis/.direnv/ruby/bin:$PATH"
fi
