#!/usr/bin/env ruby

# Renames movies from Ruby Tapas and puts them
# in the Movies directory.

# Not sure how to get ActiveSupport working from within Hazel.
def titleize(string)
  string.gsub('-', ' ')
end

original_path = ARGV[0]
original_name = File.basename(original_path, '.mp4')

pattern = /(?:RubyTapas)?(\d+)-(.+)/
match = pattern.match(original_name)

if match.nil?
  warn "Filename #{original_name} did not match pattern #{pattern.inspect}"
  exit 1
end

das_dir = File.expand_path('~/Movies/Ruby Tapas')
new_name = sprintf('%02d %s.mp4', match[1].to_i, titleize(match[2]))
new_path = "#{das_dir}/#{new_name}"

File.rename(original_path, new_path)
