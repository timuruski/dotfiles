#!/bin/bash

# rsync work files to an external volume
# https://serverfault.com/questions/25329/using-rsync-to-backup-to-an-external-drive#25398

SOURCE=(
  "$HOME/.ssh"
  "$HOME/workspace/clio"
)

# TODO: Abort if not present
DEST="${1:-/Volumes/Backup}"

for dir in ${SOURCE[@]}; do
  tarfile="$(basename $dir).tar.gz"
  tarfile="${tarfile#.}"
  dest="$DEST/$tarfile"
  tar -czf $dest "$dir"
done
