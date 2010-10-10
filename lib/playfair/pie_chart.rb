module Playfair
  class PieChart
    
    def self.create
      chart = new
      chart.add_data(&block)
      chart
    end
    
    def initialize
      @data = ValueSet.new
    end
    
    def add_data
      yield @data
    end
    
    def data
      @data.dup
    end
  end
end