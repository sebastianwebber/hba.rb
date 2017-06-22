require "test/unit"
require_relative "../lib/parser"
require_relative "../lib/rules"

class TestHbaParser < Test::Unit::TestCase
    def test_parse_local
        test_rule = "local   all             all                                     trust ### coment test ok".split
        assert_instance_of HbaRule, HbaParser.new.parse_local(2, test_rule) 
        assert_equal HbaRule.new(:line_no => 2,
                        :conn_type => "local", 
                        :db_name => "all", 
                        :user_name => "all", 
                        :comment => "coment test ok",
                        :auth_type => "trust"), 
                    HbaParser.new.parse_local(2, test_rule)
    end

    def test_parse_host
        test_rule = "hostssl    dbname             seba             192.168.0.0/24            reject ### supercomment".split
        assert_instance_of HbaRule, HbaParser.new.parse_host(2, test_rule)

        assert_equal HbaRule.new(:line_no => 2,
                        :conn_type => "hostssl", 
                        :db_name => "dbname", 
                        :user_name => "seba", 
                        :ip_addr => "192.168.0.0", 
                        :net_mask => "24", 
                        :comment => "supercomment",
                        :auth_type => "reject"),
                    HbaParser.new.parse_host(2, test_rule)
    end
    
end
