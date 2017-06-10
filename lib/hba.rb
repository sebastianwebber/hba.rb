class Hba
    def read_file file_name
        File.read file_name
    end
    
    def process_file file_name
        puts "processing #{file_name}"
        puts File.read file_name
    end
end
