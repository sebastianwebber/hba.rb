lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "rake/testtask"

Rake::TestTask.new(:test) do |t|
	t.libs << "test"
	t.verbose = false
	t.test_files = FileList["test/**/test_*.rb"]
end

task default: :test
