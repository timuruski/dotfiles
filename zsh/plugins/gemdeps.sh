function gemdeps {
  if [[ "$1" = "-d" ]]; then
    shift
    gem dependency --both $@
  else
    gem dependency --both $@ | awk '!/, development\)/'
  fi
}
