module Playfair
  class Chart < Array
    
    attr_accessor :title
    attr_reader :renderer
    
    def initialize(chart_renderer=GoogleChartRenderer)
      @renderer = chart_renderer
    end

    def value(value,label="")
      push Value.new(value,label)
    end
        
    def data(&block)
      instance_eval &block
    end
    
    def values
      collect { |value| value.value }
    end
    
    def render(type, options={})
      renderer.new(self, options).render(type)
    end
  end
  
  Value = Struct.new(:value, :label)
end