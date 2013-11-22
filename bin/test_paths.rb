#! /usr/bin/env ruby

# require 'pry'

class TestPaths
  def self.for(sources)
    Array(sources).each do |source|
      new(source).generate
    end
  end

  METHOD_PATTERN = /^ +def (?:self\.)?(\w+)/

  def initialize(source)
    @source = File.open(source, 'r')
  end

  def generate
    @source.each_line do |line|
      next unless line =~ METHOD_PATTERN
      puts path(line)
    end
  end

  def path(line)
    match = METHOD_PATTERN.match(line)
    dirname = File.dirname(@source)
    basename = File.basename(@source, '.rb')
    methodname = match[1]

    "spec/#{dirname}/#{basename}/#{methodname}_spec.rb"
  end

end

if $0 == __FILE__
  TestPaths.for ARGV
end
