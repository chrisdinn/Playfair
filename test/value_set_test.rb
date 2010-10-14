require 'test_helper'

class ValueSetTest < Test::Unit::TestCase
  
  def test_add_single_value
    v = Playfair::ValueSet.new
    
    v.add_value 100
    
    assert_equal 1, v.size
    assert_equal 100, v.first.value
  end
  
  def test_add_single_value_with_label
    v = Playfair::ValueSet.new
    
    v.add_value 100, "One hundred"
    
    assert_equal "One hundred", v.first.label
  end
  
  def test_values
    v = Playfair::ValueSet.new
    
    v.add_value 100, "One hundred"
    v.add_value 200, "Two hundred"
    
    assert_equal v.values, [100, 200]
  end
end