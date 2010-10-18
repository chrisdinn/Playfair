module Playfair
  class Renderer
    
    attr_reader :source, :width, :height
    @@chart_types = {}
    
    def initialize(chart, options={})
      @source = chart
      @width = options[:width] || 330
      @height = options[:height] || 200
    end
    
    def self.render(chart_type, &block)
      @@chart_types[self] ||= {} 
      @@chart_types[self][chart_type] = block
    end
    
    def render(chart_type)
      instance_eval &@@chart_types[self.class][chart_type]
    end
    
    protected
    
    def values
      source.values
    end
    
    def labels
      source.labels
    end
    
    def title
      source.title
    end
  end
end