require 'test_helper'

class BarChartTest < Test::Unit::TestCase

  def test_add_data
    bar = Playfair::BarChart.new
    
    bar.data do
      value 2300, "Firefox"
      value 3150, "IE"
    end
    
    assert_equal 2, bar.data.size
    assert_equal 2300, bar.data.first.value
    assert_equal "IE", bar.data.last.label
  end
  
  def test_render
    bar = Playfair::BarChart.new
    
    bar.data do
      value 90, "Firefox"
      value 55, "IE"
    end
    
    expected_chart = "http://chart.apis.google.com/chart?cht=bvs&chd=t:90,55&chxt=x,y&chxl=0:|Firefox|IE&chs=330x200"
    
    assert_equal expected_chart, bar.render
  end
  
  def test_render_with_title
    bar = Playfair::BarChart.new
    bar.title = "Internet users"
    bar.data do
      value 90, "Firefox users"
      value 55, "IE users"
    end
    
    expected_chart = "http://chart.apis.google.com/chart?cht=bvs&chd=t:90,55&chxt=x,y&chxl=0:|Firefox+users|IE+users&chs=330x200&chtt=Internet+users"
    
    assert_equal expected_chart, bar.render
  end
end