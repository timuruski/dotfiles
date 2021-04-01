# This might be redundant now.
# function glow() {
#   /usr/bin/env glow --style light $1 | less -r
# }

function mkcd {
  mkdir -p "$1" && cd "$1"
}

# Try to jump into an open vim instance.
function vv() {
  # if [ $yes_vim -eq 0 ]; then
  if jobs | egrep -q "\b(vv|vim?)\b"; then
    fg
  else
    vim $@
  fi
}

