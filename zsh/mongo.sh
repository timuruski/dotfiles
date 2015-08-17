# Controlling MongoDB
function start-mongo() {
  case "$1" in
    --daemon|-d)
      launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mongodb.plist
      ;;
    *)
      mongod --config /usr/local/etc/mongod.conf
      ;;
  esac
}

function stop-mongo() {
  launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.mongodb.plist
}
