#!/bin/bash

# Rails gunks up system gems with all its dependencies, so it's kept in quarantine when
# it's needed to "new up" another app.
#
# USAGE:
# 1. Create a rails-new directory, eg. ~/workspace/rails-new
# 2. Use direnv edit to add configuration for local rails, eg.
#
#  # Use local Ruby version
#  chruby $(cat .ruby-version)
#  use local_ruby
#
#  # Use common Rails gemset
#  gem_home ~/.config/gemsets/rails
#  use gemset rails

function rails-new() {
  dir=~/workspace/rails-new
  # direnv exec $DIR rails new --skip-bundle --skip-coffee --skip-test $@
  # direnv exec $DIR rails new $@

  case "$1" in
    -h|--help)
      direnv exec $dir rails new $@;;
    *)
      direnv exec $dir rails new --skip-bundle --skip-coffee --skip-test $@;;
  esac
}
