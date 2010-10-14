require 'test_helper'

class LineChartRendererTest < Test::Unit::TestCase
  
  def test_render
    chart = Playfair::Chart.new
    
    chart.data do
      value 90, "5"
      value 55, "10"
      value 77, "15"
      value 65, "20"
      value 74, "25"
    end
    
    expected_chart = "http://chart.apis.google.com/chart?cht=lc&chd=t:90,55,77,65,74&chxt=x,y&chxl=0:|5|10|15|20|25&chs=330x200"
    
    assert_equal expected_chart, Playfair::LineChartRenderer.render(chart)
  end
  
  def test_render_with_title
    chart = Playfair::Chart.new
    chart.title = "Internet users"
    chart.data do
      value 90, "5"
      value 55, "10"
      value 77, "15"
      value 65, "20"
      value 74, "25"
    end
    
    expected_chart = "http://chart.apis.google.com/chart?cht=lc&chd=t:90,55,77,65,74&chxt=x,y&chxl=0:|5|10|15|20|25&chs=330x200&chtt=Internet+users"
    
    assert_equal expected_chart, Playfair::LineChartRenderer.render(chart)
  end
  
end