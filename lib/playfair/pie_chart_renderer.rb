module Playfair
  class PieChartRenderer < GoogleChartRenderer
    
    def self.render(chart, options={:width => 330, :height => 200})
      labels = chart.collect{|d| CGI.escape(d.label) }
      
      rendered_chart = "#{API_URL}?cht=p&chd=t:#{chart.values.join(',')}&chl=#{labels.join('|')}"
      rendered_chart << "&chs=#{options[:width]}x#{options[:height]}"
      rendered_chart << "&chtt=#{CGI.escape(chart.title)}" if chart.title
      rendered_chart
    end
    
  end
end