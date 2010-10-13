module Playfair
  class Chart
    attr_accessor :title

    def add_data(&block)
      @data.instance_eval &block
    end
    
    def data
      @data.dup
    end
    
  end
end