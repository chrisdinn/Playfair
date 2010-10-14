module Playfair
  class Chart
    API_URL = "http://chart.apis.google.com/chart"
    
    attr_accessor :title

    def initialize
      @data = ValueSet.new
    end

    def value(*args)
      @data.add_value *args
    end
        
    def data(&block)
      if block_given?
        instance_eval &block
      else
        @data.dup
      end
    end
  end
end