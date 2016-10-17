# Controlling PostgreSQL
function start-psql() {
  case "$1" in
    --daemon|-d)
      launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
      ;;
    *)
      postgres -D /usr/local/var/postgres
      ;;
  esac
}

function stop-psql() {
  launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
}
