#! /usr/bin/env ruby

$:.unshift File.dirname(__FILE__)
require 'lib/dotfiles'


# Execute installer.
Dotfiles.exec do |installer|
  installer.dotfile '*'
  installer.ignore %w[ Gemfile* lib/ Rakefile README.md tmp/ ]
  installer.symlink_only %w[ bin ]
end
