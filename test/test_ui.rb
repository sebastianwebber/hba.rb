require "test/unit"
require_relative "../lib/ui"

class TestHbaUI < Test::Unit::TestCase
    
    def test_wrongfile
        assert_raise( Errno::ENOENT ) { HbaUI.new.display_file('wrong/path/to/hba.conf') }
    end

    def test_okfile
        assert_raise( Errno::ENOENT ) { HbaUI.new.display_file('samples/pg_hba.conf') }
    end
end