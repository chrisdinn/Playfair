module Playfair
  class Chart < Array
    
    attr_accessor :title
    attr_accessor :renderer
    
    def initialize(&block)
      @renderer = GoogleChartRenderer
      instance_eval &block
    end

    def value(value,label="")
      push Value.new(value,label)
    end
    
    def values
      collect { |value| value.value }
    end  
    
    def labels
      collect { |value| value.label }
    end
    
    def render(type, options={})  
      renderer.new(self, options).render(type)
    end
  end
  
  Value = Struct.new(:value, :label)
end