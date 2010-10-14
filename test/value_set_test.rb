require 'test_helper'

class ValueSetTest < Test::Unit::TestCase
  
  def test_add_single_value
    v = Playfair::ValueSet.new
    
    v.add_value 100
    
    assert 1, v.size
    assert 100, v.first.value
  end
  
  def test_add_single_value_with_label
    v = Playfair::ValueSet.new
    
    v.add_value 100, "One hundred"
    
    assert "One hundred", v.first.label
  end
end