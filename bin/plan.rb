#! /usr/bin/env ruby

require 'date'
require 'optparse'
require 'pathname'

PLANS_DIR = Pathname.new('~/plans').expand_path

def parse_date(arg)
  case arg
  when 'tomorrow' then Date.today.next_day
  when 'yesterday' then Date.today.prev_day
  else Date.today
  end
end

def plan_file(date)
  year = date.strftime('%Y')
  plan_file = date.strftime('%m-%d.mdown')
  PLANS_DIR.join(year, plan_file)
end

def new_plan(date, path)
  header = date.strftime('# %Y-%m-%d: %A, %d %B %Y')
  path.open('w') do |f|
    f << header
    f << "\n\n"
  end
end

date = parse_date(ARGV.shift)
path = plan_file(date)
new_plan(date, path) unless path.exist?

exec('vi', path.to_s, '+$')
