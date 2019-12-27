#!/bin/bash

# Jets (like Rails) gunks up system gems with all its dependencies, so it's kept in quarantine
# when it's needed to "new up" another app.
#
# http://rubyonjets.com
#
# USAGE:
# 1. Create a jets-new directory, eg. ~/workspace/jets-new
# 2. Use direnv edit to add configuration for local jets, eg.
#
#  # Use local Ruby version
#  chruby $(cat .ruby-version)
#  use local_ruby
#
#  # Use common Jets gemset
#  gem_home ~/.config/gemsets/jets
#  use gemset jets

function jets-new() {
  local jets_dir=~/workspace/jets-new
  direnv exec $jets_dir jets new $@
}
