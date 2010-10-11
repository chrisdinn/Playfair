require 'cgi'

module Playfair
  class PieChart
    attr_accessor :title
    
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
    
    def render(options={:width => 330, :height => 200})
      values = @data.collect{|d| d.value }
      labels = @data.collect{|d| CGI.escape(d.label) }
      rendered_chart = "http://chart.apis.google.com/chart?cht=p&chd=t:#{values.join(',')}&chl=#{labels.join('|')}&chs=#{options[:width]}x#{options[:height]}"
      rendered_chart << "&chtt=#{CGI.escape(title)}" if title
      rendered_chart
    end
  end
end