# TODO Fallback if fzf isn't installed
# function ws() { cd ~/workspace/$1; }
# TODO Implement `ws -` -> cd ~/workspace

workspace_dirs() {
  local workspace="${HOME}/workspace/"
  fd --no-ignore-vcs --type directory --maxdepth 1 . "${workspace}" | sed -e "s;${workspace};;"
}

filter() {
  fzf --height=50% $@
}

ws() {
  if [[ $# -gt 0 ]]; then
    target=$(workspace_dirs | filter --exact --select-1 --query $1)
  else
    target=$(workspace_dirs | filter)
  fi

  cd "${target}"
}
