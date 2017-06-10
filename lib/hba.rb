require_relative "rules"

class Hba

    def parse_local line
        HbaRule.new :conn_type => line[0], :db_name => line[1], :user_name => line[2], :auth_type => line[3]
    end
    def parse_host line
        if line.length == 5
            address = line[3].split("/")
            HbaRule.new :conn_type => line[0], :db_name => line[1], :user_name => line[2], :ip_mask => address[0], :net_mask => address[1], :auth_type => line[4]
        else 
            HbaRule.new :conn_type => line[0], :db_name => line[1], :user_name => line[2], :ip_mask => line[3], :net_mask => line[4], :auth_type => line[5]
        end
    end
    

    def parse_line line_content
        line = line_content.split
        if line[0] == "local"
            rule =  parse_local line
        else 
            rule = parse_host line
        end

        rule
    end

    def read_file file_name
        File.read(file_name).each_line do |line|
            puts parse_line(line) unless line.strip.start_with?("#") or line.strip == ""
        end
    end
    
    def process_file file_name
        puts "processing #{file_name}"
        read_file file_name
    end
end
