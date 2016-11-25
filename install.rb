#! /usr/bin/env ruby

$:.unshift File.dirname(__FILE__)
require 'lib/dotfiles'

IGNORE = %w[
  Brewfile
  Gemfile*
  brewed
  README.md
  Rakefile
  lib/
  tmp/
]

# Execute installer.
Dotfiles.exec do |installer|
  installer.dotfile '*'
  installer.ignore IGNORE
  installer.symlink_only %w[ bin ]
end
