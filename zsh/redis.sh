# Controlling Redis from Homebrew;

function start-redis() {
  case "$1" in
    --daemon|-d)
      launchctl load ~/Library/LaunchAgents/homebrew.mxcl.redis.plist
      ;;
    *)
      redis-server /usr/local/etc/redis.conf
      ;;
  esac
}

function stop-redis() {
  launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.redis.plist
}
