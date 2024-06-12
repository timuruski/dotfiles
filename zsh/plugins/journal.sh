# Command line journal
# https://jodavaho.io/posts/bash-journalling.html
# https://jodavaho.io/posts/bullet-journalling.html
# This depends on gdate from coreutils

export notedir="$HOME/workspace/journal"

function journal(){
  # TODO: Add date header for new files.
  local filepath="$notedir/$(gdate +%Y-%m-%d -d "$*").md"
  # Use zed.dev to 
  zed $filepath
}

alias j=journal
