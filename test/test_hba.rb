require "test/unit"
require_relative "../lib/hba"
require_relative "../lib/rules"

class TestHba < Test::Unit::TestCase
    
    def test_wrongfile
        assert_raise( Errno::ENOENT ) { Hba.new.process_file('wrong/path/to/hba.conf') }
    end

    def test_okfile
        assert_raise( Errno::ENOENT ) { Hba.new.process_file('samples/pg_hba.conf') }
    end

    def test_parse_local
        test_rule = "local   all             all                                     trust ### coment test ok".split
        assert_instance_of HbaRule, Hba.new.parse_local(2, test_rule) 
        assert_equal HbaRule.new(:line_no => 2,
                        :conn_type => "local", 
                        :db_name => "all", 
                        :user_name => "all", 
                        :auth_type => "trust"), 
                    Hba.new.parse_local(2, test_rule)
    end

    def test_parse_host
        test_rule = "hostssl    dbname             seba             192.168.0.0/24            reject ### supercomment".split
        assert_instance_of HbaRule, Hba.new.parse_host(2, test_rule)

        assert_equal HbaRule.new(:line_no => 2,
                        :conn_type => "hostssl", 
                        :db_name => "dbname", 
                        :user_name => "seba", 
                        :ip_mask => "192.168.0.0", 
                        :net_mask => "24", 
                        :auth_type => "reject"),
                    Hba.new.parse_host(2, test_rule)
    end
    
end
