## PROMPT
status () {
  if [[ $? -gt 0 ]]; then
    printf "\e[31m$\e[0m"
  else
    printf "$"
  fi
}

hostname_ () {
  printf "\e[33m`hostname -s`\e[0m"
}

dirname_ () {
  printf "\e[4m`pwd | xargs basename`\e[0m"
}

# PS1="\e[2K\$(hostname_):\$(dirname_) \$(status) "
PS1="\e[2K\e[33m\h\e[0m:\e[4m\W\e[0m \$(status) "

# CHRUBY
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh

# Bootstrap chruby for shell scripts and git-hooks.
chruby_auto

## DIRENV
# eval "$(direnv hook bash)"
