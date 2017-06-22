require_relative '../lib/ui'

require "docopt"
doc = <<DOCOPT
A pg_hba.conf manager

Usage:
  pg_hba show --hba-file=FILENAME
  pg_hba -h | --help
  pg_hba --version

Options:
  -h, --help                         Show this screen.
  -v, --version                      Show version.
  -f FILENAME, --hba-file=FILENAME   Path to the pg_hba.conf file

DOCOPT

begin
  require "pp"
  out = Docopt::docopt(doc)

  if out["show"]
    cmd = HbaUI.new
    cmd.display_file out["--hba-file"]
  elsif out["--version"]
      puts "pg_hba 0.1a"
  end 


rescue Docopt::Exit => e
  puts e.message
end
