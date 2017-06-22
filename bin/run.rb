require_relative '../lib/HbaParser'

cmd = HbaParser.new
raise("Missing filename!") unless ARGV.length >= 1
cmd.process_file ARGV[0]