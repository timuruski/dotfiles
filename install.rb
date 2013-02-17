#! /usr/bin/env ruby

$:.unshift File.dirname(__FILE__)
require 'lib/dotfiles'


# Execute installer.
Dotfiles.exec do |installer|
  installer.dotfile '*'
  installer.ignore %w[ lib/ Rakefile README.md tmp/ ]
  installer.symlink_only 'bin'
end
