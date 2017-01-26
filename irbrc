require 'irb/completion'

ARGV.concat ["--readline", "--prompt-mode", "simple"]
IRB.conf[:SAVE_HISTORY] = 2000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"