class Toggle
    @@flags = {
            "test" => true,
            "show_rates_on_catalog" => false
    }
  
    def self.turn(flag, value)
        @@flags[flag]= value
    end

    def self.on?(flag)
        !@@flags[flag].nil? && @@flags[flag] 
    end
end
