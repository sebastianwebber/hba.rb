class HbaRule
    attr_accessor   :line_no, 
                    :conn_type, 
                    :db_name, 
                    :user_name, 
                    :ip_addr, 
                    :net_mask, 
                    :auth_type, 
                    :comment

    def initialize args
        args.each do |k,v|
            instance_variable_set("@#{k}", v) unless v.nil?
        end
    end
    
end
