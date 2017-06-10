require_relative "rules"

class Hba
    def parse_line line_content
        line_content
    end

    def read_file file_name
        File.read(file_name).each_line do |line|
            puts(line) unless line.strip.start_with?("#")
        end
    end
    
    def process_file file_name
        puts "processing #{file_name}"
        read_file file_name
    end
end
