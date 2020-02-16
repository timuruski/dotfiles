# TODO Fallback if fzf isn't installed
# function ws() { cd ~/workspace/$1; }

workspace_dirs() {
  fd --type directory --maxdepth 1 . "${workspace}" | sed -e "s;${workspace};;"
}

filter() {
  fzf --height=50% $@
}

ws() {
  local workspace="${HOME}/workspace/"
  if [[ $# -gt 0 ]]; then
    target=$(workspace_dirs | filter --exact --select-1 --query $1)
  else
    target=$(workspace_dirs | filter)
  fi

  cd "${target}"
}
