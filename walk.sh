#!/bin/bash
src_dir="$(git rev-parse --show-toplevel)/sdfs"
file=".team"

while [ ! -z "$src_dir" ] && [ ! -f "$src_dir/$file" ]; do
  src_dir="${src_dir%\/*}"
  echo "${src_dir}/$file"
done


# src_dir=$(cd "$(dirname "$0")/.."; pwd)
# echo $src_dir

# src_dir=$(cd "${0%/*}/.."; pwd)
# echo $src_dir
