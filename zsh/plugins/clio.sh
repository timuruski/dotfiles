# Convert: https://themis.atlassian.net/browse/CLIO-71532 -> clio-71532
function issue() {
  local url=$1
  shift

  echo "${url}-${*}" | sed "s/https:\/\/themis.atlassian.net\/browse\/CLIO-/clio-/"
}
