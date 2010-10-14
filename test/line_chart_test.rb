require 'test_helper'

class LineChartTest < Test::Unit::TestCase

  def test_add_data
    line = Playfair::LineChart.new
    
    line.data do
      value 2300, "Firefox"
      value 3150, "IE"
    end
    
    assert_equal 2, line.data.size
    assert_equal 2300, line.data.first.value
    assert_equal "IE", line.data.last.label
  end
  
  def test_render
    line = Playfair::LineChart.new
    
    line.data do
      value 90, "5"
      value 55, "10"
      value 77, "15"
      value 65, "20"
      value 74, "25"
    end
    
    expected_chart = "http://chart.apis.google.com/chart?cht=lc&chd=t:90,55,77,65,74&chxt=x,y&chxl=0:|5|10|15|20|25&chs=330x200"
    
    assert_equal expected_chart, line.render
  end
  
  def test_render_with_title
    line = Playfair::LineChart.new
    line.title = "Internet users"
    line.data do
      value 90, "5"
      value 55, "10"
      value 77, "15"
      value 65, "20"
      value 74, "25"
    end
    
    expected_chart = "http://chart.apis.google.com/chart?cht=lc&chd=t:90,55,77,65,74&chxt=x,y&chxl=0:|5|10|15|20|25&chs=330x200&chtt=Internet+users"
    
    assert_equal expected_chart, line.render
  end
end