module Playfair 
  class ValueSet < Array
    
    def add_value(value,label="")
      self << Value.new(value, label)
    end
    
    def values
      collect { |value| value.value }
    end
  end
  
  Value = Struct.new(:value, :label)
end