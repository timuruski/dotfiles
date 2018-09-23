# Customize prompt
# local cmd_status="%(?,%{$reset_color%},%{$fg[red]%})⑀%{$reset_color%}"

git_repo_path () {
  git rev-parse --git-dir 2>/dev/null
}

git_branch_name () {
  git rev-parse --abbrev-ref HEAD 2>/dev/null
}

git_commit_sha () {
  git rev-parse --short HEAD 2>/dev/null
}

# git_prompt () {
#   echo $(git_branch_name) $(git_commit_sha) $(git_mode)
#   [git_branch_name, git_commit_sha, rebasing_etc].compact.join(":")
# }

# Original prompt
# PROMPT=" \${cmd_status} %{\$fg[blue]%}%m%{\$reset_color%}:%U%1~%u "
# RPROMPT='%{$fg[brblack]%}$(~/bin/git-cwd-info.rb)%{$reset_color%}'

# Experimental split line prompt:
# PROMPT=" %{\$fg[blue]%}%m%{\$reset_color%}:%U%1~%u:%{\$fg[brblack]%}:\$(~/bin/git-cwd-info.rb)%{\$reset_color%}
#  \${cmd_status} "
# PROMPT=" %{\$fg[blue]%}%m%{\$reset_color%}:%U%1~\$(~/bin/git-cwd-info.rb)%{\$reset_color%}
#  \${cmd_status} "

# One-line prompt...
# PROMPT=" %{\$fg[blue]%}%m%{\$reset_color%}:%U%1~\$(~/bin/git-cwd-info.rb)%{\$reset_color%} \${cmd_status} "

PROMPT=" %U%1~\$($HOME/bin/git_prompt.rb)%u $ "
