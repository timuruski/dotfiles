#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

# Emits Git metadata for use in a Zsh prompt.
#
# AUTHOR:
#    Ben Hoskings
#   https://github.com/benhoskings/dot-files/blob/master/files/bin/git_cwd_info
#
# MODIFIED:
#    Geoffrey Grosenbach http://peepcode.com

# The methods that get called more than once are memoized.

def git_repo_path
  @git_repo_path ||= `git rev-parse --git-dir 2>/dev/null`.strip
end

def in_git_repo
  !git_repo_path.empty? &&
  git_repo_path != '~' &&
  git_repo_path != "#{ENV['HOME']}/.git"
end

def git_branch
  branch_name = `git rev-parse --abbrev-ref HEAD 2>/dev/null`.chomp
  "%B#{branch_name}%b"
end

def git_commit_sha
  `git rev-parse --short HEAD 2>/dev/null`.strip
end

def git_mode
  if File.exists?(File.join(git_repo_path, 'BISECT_LOG'))
    mode = "bisect"
  elsif File.exists?(File.join(git_repo_path, 'MERGE_HEAD'))
    mode = "merge"
  elsif File.exists?(File.join(git_repo_path, 'CHERRY_PICK_HEAD'))
    mode = "cherry-pick"
  elsif %w[rebase rebase-apply rebase-merge ../.dotest].any? {|d| File.exists?(File.join(git_repo_path, d)) }
    mode = "rebase"
  end

  if mode
    "%F{red}%B" + mode.to_s + "%f%b"
  end
end

if in_git_repo
  # print ":", [git_parse_branch, git_head_commit_id, rebasing_etc].compact.join(":")
  print " ", [git_branch, git_commit_sha, git_mode].compact.join(" ")
end
