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

        @conn_type ||= "local"
        @user_name ||= "all"
        @db_name ||= "all"
        @auth_type ||= "md5"
    end

    def to_s
        "#{@line_no}:#{@conn_type}\t#{@db_name}\t#{@user_name}\t#{@auth_type}"
        "#{@line_no}:#{@conn_type}\t#{@db_name}\t#{@user_name}\t#{@ip_addr}/#{@net_mask}\t#{@auth_type}" unless [ 'host', 'hostssl'].include?(:conn_type)
    end

    def ==(other)
        other.class == self.class && other.state == self.state
    end

    def state
        self.instance_variables.map { |variable| self.instance_variable_get variable }
    end

    def valid?
        true
        false unless [ 'local', 'host', 'hostssl'].include?(:conn_type)
    end

end
