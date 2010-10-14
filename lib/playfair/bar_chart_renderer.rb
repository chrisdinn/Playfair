module Playfair
  class BarChartRenderer < GoogleChartRenderer
    
    def self.render(chart, options={:width => 330, :height => 200})
      labels = chart.collect{|d| CGI.escape(d.label) }
      
      rendered_chart = "#{API_URL}?cht=bvs&chd=t:#{chart.values.join(',')}&chxt=x,y&chxl=0:|#{labels.join('|')}"
      rendered_chart << "&chs=#{options[:width]}x#{options[:height]}"
      rendered_chart << "&chtt=#{CGI.escape(chart.title)}" if chart.title
      rendered_chart
    end
    
  end
end