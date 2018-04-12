# coding: utf-8
# ruby

require 'test/unit'

class Person
  attr_checked :age do |v|
    v >= 18
  end
end

class TestCheckedAttributes < Test::Unit::TestCase 
  def setup
    @bob = Person.new
  end
  
  def test_accepts_valid_values
    @bob.age = 20
    assert_equal 20, @bob.age
  end
  
  def test_refuses_invalid_values
    assert_raises RuntimeError, 'Invalid attribute' do
      @bob.age = 17
    end
  end
end
