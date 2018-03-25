require 'test_helper'

class CarTest < ActiveSupport::TestCase

  test "should have an engine with the car" do
    car = Car.find_by(brand: "Ferrari")
    assert_not_nil car.engine
    assert_not_empty car.engine.engine_number
  end

  test "should have a petrol spark in engine" do
    car = Car.find_by(brand: "Ferrari")
    assert_not_nil car.spark
    assert "petrol", car.spark.fuel
  end
end
