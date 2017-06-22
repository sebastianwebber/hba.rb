require_relative '../lib/ui'

cmd = HbaUI.new
raise("Missing filename!") unless ARGV.length >= 1
cmd.display_file ARGV[0]