require 'test_helper'

class PieChartRendererTest < Test::Unit::TestCase
  
  def test_render
    chart = Playfair::Chart.new
    
    chart.data do
      value 90, "Firefox"
      value 55, "IE"
    end
    
    expected_chart = "http://chart.apis.google.com/chart?cht=p&chd=t:90,55&chl=Firefox|IE&chs=330x200"
    
    assert_equal expected_chart, Playfair::PieChartRenderer.render(chart)
  end
  
  def test_render_with_title
    chart = Playfair::Chart.new
    chart.title = "Internet users"
    chart.data do
      value 90, "Firefox users"
      value 55, "IE users"
    end
    
    expected_chart = "http://chart.apis.google.com/chart?cht=p&chd=t:90,55&chl=Firefox+users|IE+users&chs=330x200&chtt=Internet+users"
    
    assert_equal expected_chart, Playfair::PieChartRenderer.render(chart)
  end
  
end