require_relative '../lib/hba'

cmd = Hba.new
raise("Missing filename!") unless ARGV.length >= 1
cmd.process_file ARGV[0]