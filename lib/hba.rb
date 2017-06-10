require_relative "rules"

class Hba
    def parse_line line_content
        line = line_content.split
        rule = HbaRule.new
        rule.conn_type = line[0]
        rule.db_name = line[1]
        rule.user_name = line[2]

        if rule.conn_type == "local"
            rule.auth_type = line[3]
        elsif line.length == 5

            address = line[3].split("/")
            rule.ip_addr = address[0]
            rule.net_mask = address[1]
            rule.auth_type = line[4]
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
