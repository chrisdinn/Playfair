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
    
    def render(options={:width => 280, :height => 200})
      values = @data.collect{|d| d.value }
      labels = @data.collect{|d| d.label }
      "http://chart.apis.google.com/chart?cht=p&chd=t:#{values.join(',')}&chl=#{labels.join('|')}&chs=280x200"
    end
  end
end