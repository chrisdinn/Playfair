require 'cgi'

module Playfair
  class GoogleChartRenderer < Renderer
    
    API_URL = "http://chart.apis.google.com/chart"
    
    render :bar_chart do
      chart_url "cht=bvs&chd=t:#{values.join(',')}&chxt=x,y&chxl=0:|#{labels.join('|')}"
    end
    
    render :line_chart do
      chart_url "cht=lc&chd=t:#{values.join(',')}&chxt=x,y&chxl=0:|#{labels.join('|')}"
    end
    
    render :pie_chart do
      chart_url "cht=p&chd=t:#{values.join(',')}&chl=#{labels.join('|')}"
    end
    
    protected
    
    def chart_url(chart_params)
      rendered_chart = "#{API_URL}?#{chart_params}"
      rendered_chart << "&chs=#{width}x#{height}"
      rendered_chart << "&chtt=#{title}" if title
      rendered_chart
    end
    
    def labels
      source.collect { |v| CGI.escape(v.label.to_s) }
    end
    
    def title
      CGI.escape(source.title) if source.title
    end
    
  end
end