require 'test_helper'

class GoogleChartRendererTest < Test::Unit::TestCase
  
  def test_render_bar_chart
    chart = Playfair::Chart.new do
      value 90, "Firefox"
      value 55, "IE"
    end
    chart.renderer = Playfair::GoogleChartRenderer
    
    expected_chart = "http://chart.apis.google.com/chart?cht=bvs&chd=t:90,55&chxt=x,y&chxl=0:|Firefox|IE&chs=330x200"
    assert_equal expected_chart, chart.render(:bar_chart)
  end
  
  def test_render_bar_chart_with_title
    chart = Playfair::Chart.new do
      value 90, "Firefox users"
      value 55, "IE users"
    end
    chart.title = "Internet users"
    chart.renderer = Playfair::GoogleChartRenderer
    
    expected_chart = "http://chart.apis.google.com/chart?cht=bvs&chd=t:90,55&chxt=x,y&chxl=0:|Firefox+users|IE+users&chs=330x200&chtt=Internet+users"
    assert_equal expected_chart, chart.render(:bar_chart)
  end
  
  
  def test_render_pie_chart
    chart = Playfair::Chart.new do
      value 90, "Firefox"
      value 55, "IE"
    end
    chart.renderer = Playfair::GoogleChartRenderer
    
    expected_chart = "http://chart.apis.google.com/chart?cht=p&chd=t:90,55&chl=Firefox|IE&chs=330x200"
    assert_equal expected_chart, chart.render(:pie_chart)
  end
  
  def test_render_pie_chart_with_title
    chart = Playfair::Chart.new do
      value 90, "Firefox users"
      value 55, "IE users"
    end
    chart.renderer = Playfair::GoogleChartRenderer
    chart.title = "Internet users"
    
    expected_chart = "http://chart.apis.google.com/chart?cht=p&chd=t:90,55&chl=Firefox+users|IE+users&chs=330x200&chtt=Internet+users"
    assert_equal expected_chart, chart.render(:pie_chart)
  end
  
  def test_render_line_chart
    chart = Playfair::Chart.new do
      value 90, "5am"
      value 55, "10am"
      value 77, "3pm"
      value 65, "9pm"
      value 74, "1am"
    end
    chart.renderer = Playfair::GoogleChartRenderer
    
    expected_chart = "http://chart.apis.google.com/chart?cht=lc&chd=t:90,55,77,65,74&chxt=x,y&chxl=0:|5am|10am|3pm|9pm|1am&chs=330x200"
    assert_equal expected_chart, chart.render(:line_chart)
  end
  
  def test_render_line_chart_with_title
    chart = Playfair::Chart.new do
      value 90, "5am"
      value 55, "10am"
      value 77, "3pm"
      value 65, "9pm"
      value 74, "1am"
    end
    chart.title = "Internet users"
    chart.renderer = Playfair::GoogleChartRenderer
    
    expected_chart = "http://chart.apis.google.com/chart?cht=lc&chd=t:90,55,77,65,74&chxt=x,y&chxl=0:|5am|10am|3pm|9pm|1am&chs=330x200&chtt=Internet+users"
    assert_equal expected_chart, chart.render(:line_chart)
  end
  
end