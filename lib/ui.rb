require_relative "../lib/parser"

class HbaUI

    ### for dev purposes only
    def display_file file_name
        rules = HbaParser.new.read_file file_name

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