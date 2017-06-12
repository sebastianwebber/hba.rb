require_relative "rules"

class Hba

    def parse_local line_no, line
        HbaRule.new :line_no => line_no,
                    :conn_type => line[0], 
                    :db_name => line[1], 
                    :user_name => line[2], 
                    :auth_type => line[3]
    end

    def parse_host line_no, line
        if line[3].include? "/"
            address = line[3].split("/")
            line[3] = address[0]
            line.insert(4,address[1])
        end
        HbaRule.new :line_no => line_no,
                    :conn_type => line[0], 
                    :db_name => line[1], 
                    :user_name => line[2], 
                    :ip_mask => line[3], 
                    :net_mask => line[4], 
                    :auth_type => line[5]
    end
    

    def parse_line line_no, line_content
        line = line_content.split
        if line[0] == "local"
            parse_local line_no, line
        else 
            parse_host line_no, line
        end
    end

    def read_file file_name
        line_no = 0
        rule_list = []
        File.read(file_name).each_line do |line|
            line_no += 1
            rule_list << parse_line(line_no, line) unless line.strip.start_with?("#") or line.strip == ""
        end

        rule_list
    end
    
    def process_file file_name
        puts "processing #{file_name}"
        rules = read_file file_name

        rules.each do |rule|
            puts rule.inspect
        end
    end
end
