# Command line journal
# https://jodavaho.io/posts/bash-journalling.html
# https://jodavaho.io/posts/bullet-journalling.html
# This depends on gdate from coreutils

export notedir="$HOME/workspace/journal"

function journal(){
  vi $notedir/$(gdate +%Y-%m-%d -d "$*").md
}

alias j=journal
