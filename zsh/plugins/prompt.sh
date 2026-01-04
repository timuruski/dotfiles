# Add git metadata to the prompt.

function git_repo_path {
  if [[ $# -eq 0 ]]; then
    git rev-parse --path-format=absolute --git-dir 2>/dev/null
  else
    git rev-parse --path-format=absolute --git-path "$@" 2>/dev/null
  fi
}

function git_branch {
  git rev-parse --abbrev-ref HEAD 2>/dev/null
}

function git_commit_sha {
  git rev-parse --short HEAD 2>/dev/null
}

function git_mode {
  # local git_repo_path=$(git_repo_path)
  local git_repo_path=$1
  if [[ -f "${git_repo_path}/BISECT_LOG" ]]; then
    echo "bisect"
  elif [[ -f "${git_repo_path}/MERGE_HEAD" ]]; then
    echo "merge"
  elif [[ -f "${git_repo_path}/CHERRY_PICK_HEAD" ]]; then
    echo "cherry-pick"
  elif [[ -e "${git_repo_path}/rebase" || -e "${git_repo_path}/rebase-apply" || -e "${git_repo_path}/rebase-merge" || -f "${git_repo_path}/dotest" ]]; then
    echo "rebase"
  fi
}

# TODO: Trim string when git mode is empty.
function git_prompt {
  local git_repo_path=$(git_repo_path)
  if [[ -n "$git_repo_path" ]]; then
    echo -n "" "%B$(git_branch)%b" $(git_commit_sha)

    if [[ -n $(git_mode "${git_repo_path}") ]]; then
      echo -n " %F{red}%B$(git_mode)%f%b"
    fi
  fi
}

# PROMPT=" %U%1~%u $ "
PROMPT=" %U%1~\$(git_prompt)%u $ "
