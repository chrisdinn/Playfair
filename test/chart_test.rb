require 'test_helper'

class ChartTest < Test::Unit::TestCase
  
  def test_add_data
    chart = Playfair::Chart.new do
      value 2300, "Firefox"
      value 3150, "IE"
    end
    
    assert_equal 2, chart.size
    assert_equal 2300, chart.first.value
    assert_equal "IE", chart.last.label
  end
  
  def test_add_single_value
    chart = Playfair::Chart.new do
      value 100
    end
    
    assert_equal 1, chart.size
    assert_equal 100, chart.first.value
  end
  
  def test_add_single_value_with_label
    chart = Playfair::Chart.new do
      value 100, "One hundred"
    end
    
    assert_equal "One hundred", chart.first.label
  end
  
  def test_values
    chart = Playfair::Chart.new do
      value 100, "One hundred"
      value 200, "Two hundred"
    end
    
    assert_equal chart.values, [100, 200]
  end
end