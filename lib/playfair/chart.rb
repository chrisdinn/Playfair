module Playfair
  class Chart < Array
    
    attr_accessor :title

    def value(value,label="")
      push Value.new(value,label)
    end
        
    def data(&block)
      if block_given?
        instance_eval &block
      else
        dup
      end
    end
    
    def values
      collect { |value| value.value }
    end
  end
  
  Value = Struct.new(:value, :label)
end