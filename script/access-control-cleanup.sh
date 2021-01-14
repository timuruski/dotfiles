ag "^ *(public|private|protected) *$" |\
  awk '{ sub(/:[0-9]+:/, "", $1); MATCHES[$1]++ }; END { for(filename in MATCHES) if(MATCHES[filename] > 1) { print MATCHES[filename] ": " filename } }' |\
  sort

