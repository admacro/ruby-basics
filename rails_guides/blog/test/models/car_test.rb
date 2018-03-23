require 'test_helper'

class CarTest < ActiveSupport::TestCase

  test "should have an engine with the car" do
    car = Car.find_by(brand: "Ferrari")
    assert_not_nil car.engine
    assert_not_empty car.engine.engine_number
  end
  
end
