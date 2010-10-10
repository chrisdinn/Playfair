require 'test_helper'

class PieChartTest < Test::Unit::TestCase

  def test_add_data
    pie = Playfair::PieChart.new
    
    pie.add_data do |data|
      data.add 2300, "Firefox"
      data.add 3150, "IE"
    end
    
    assert_equal 2, pie.data.size
    assert_equal 2300, pie.data.first.value
    assert_equal "IE", pie.data.last.label
  end
  
  def test_render
    pie = Playfair::PieChart.new
    
    pie.add_data do |data|
      data.add 90, "Firefox"
      data.add 55, "IE"
    end
    
    expected_chart = "http://chart.apis.google.com/chart?cht=p&chd=t:90,55&chl=Firefox|IE&chs=280x200"
    
    assert_equal expected_chart, pie.render
  end
  
end