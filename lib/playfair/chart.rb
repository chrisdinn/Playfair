module Playfair
  class Chart
    attr_accessor :title

    def add_data
      yield @data
    end
    
    def data
      @data.dup
    end
    
  end
end