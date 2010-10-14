module Playfair
  class BarChart < Chart
    
    def initialize
      @data = ValueSet.new
    end
    
    def value(*args)
      @data.add *args
    end
    
    def render(options={:width => 330, :height => 200})
      values = @data.collect{|d| d.value }
      labels = @data.collect{|d| CGI.escape(d.label) }
      
      rendered_chart = "http://chart.apis.google.com/chart?cht=bvs&chd=t:#{values.join(',')}&chxt=x,y&chxl=0:|#{labels.join('|')}"
      rendered_chart << "&chs=#{options[:width]}x#{options[:height]}"
      rendered_chart << "&chtt=#{CGI.escape(title)}" if title
      rendered_chart
    end
  end
end