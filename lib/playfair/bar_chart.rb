require 'cgi'

module Playfair
  class BarChart < Chart
    
    def render(options={:width => 330, :height => 200})
      labels = @data.collect{|d| CGI.escape(d.label) }
      
      rendered_chart = "#{API_URL}?cht=bvs&chd=t:#{@data.values.join(',')}&chxt=x,y&chxl=0:|#{labels.join('|')}"
      rendered_chart << "&chs=#{options[:width]}x#{options[:height]}"
      rendered_chart << "&chtt=#{CGI.escape(title)}" if title
      rendered_chart
    end
    
  end
end