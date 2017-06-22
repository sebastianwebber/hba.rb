require_relative "rules"
require 'terminal-table'


class HbaParser

    def join_comments pos, line
        line[pos..(line.length-1)].join(" ") unless line[pos].nil?
    end 

    def parse_local line_no, line
        HbaRule.new :line_no => line_no,
                    :conn_type => line[0], 
                    :db_name => line[1], 
                    :user_name => line[2], 
                    :auth_type => line[3], 
                    :comment => join_comments(5, line)
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
                    :ip_addr => line[3], 
                    :net_mask => line[4], 
                    :auth_type => line[5],
                    :comment => join_comments(7, line)
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


    ### for dev purposes only
    def process_file file_name
        rules = read_file file_name

        table = Terminal::Table.new do |t|
            t.headings = ['line', 'type', 'database', 'user', 'ip addr', 'mask', 'auth', 'comment']
            # t.style = { :width => 100}

            rules.each do |rule|
                # puts rule.to_s
                t.add_row [
                    coalesce(rule.line_no),
                    coalesce(rule.conn_type),
                    coalesce(rule.db_name),
                    coalesce(rule.user_name),
                    coalesce(rule.ip_addr),
                    coalesce(rule.net_mask),
                    coalesce(rule.auth_type),
                    coalesce(rule.comment)
                ]
            end
        end

        puts table
    end

    def coalesce value, new_default = "~"
        if value.nil?
            new_default
        else
            value
        end
    end
end
