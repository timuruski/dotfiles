# Controlling PostgreSQL
function start-postgres() {
  case "$1" in
    --daemon|-d)
      launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
      ;;
    *)
      postgres -D /usr/local/var/postgres
      ;;
  esac
}

function stop-postgres() {
  launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
}
