# Controlling Elasticsearch
function start-elasticsearch() {
  case "$1" in
    --daemon|-d)
      launchctl load ~/Library/LaunchAgents/homebrew.mxcl.elasticsearch.plist
      ;;
    *)
      elasticsearch
      ;;
  esac
}

function stop-elasticsearch() {
  launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.elasticsearch.plist
}
