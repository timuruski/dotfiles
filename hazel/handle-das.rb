#!/usr/bin/env ruby

# Renames movies from Destroy All Software and puts them 
# in the Movies directory.

# Not sure how to get ActiveSupport working from within Hazel.
def titleize(string)
  string.gsub('-', ' ').gsub(/\b([a-z])/) { |m| m.capitalize }
end

original_path = ARGV[0]
original_name = File.basename(original_path, '.mov')

pattern = /das-(\d+)-(.+)/
match = pattern.match(original_name)

das_dir = File.expand_path('~/Movies/Destroy All Software')
new_name = sprintf('%02d %s.mov', match[1].to_i, titleize(match[2]))
new_path = "#{das_dir}/#{new_name}"

File.rename(original_path, new_path)
