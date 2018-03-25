require 'test_helper'

class TireTest < ActiveSupport::TestCase

  test "should save 12 tires for a truck" do
    truck = Truck.create(brand: "Tesla")

    # don't do `Array.new(12, Tire.new(size: 30))`
    # all 12 Tire objects will be the same and only one record will be saved to DB
    12.times do
      truck.tires << Tire.new(size: 30)
    end
    
    truck_tires = Tire.where(rollable_type: "Truck")
    assert_not_empty truck_tires
    assert_equal 12, truck_tires.size
  end

  test "should be a Giant bicycle if rollable type is Bicycle" do
    bicycle_tires = Tire.where(rollable_type: "Bicycle")
    assert_equal 2, bicycle_tires.size

    bicycle_tires.each do |tire|
      assert_not_nil tire.rollable # access to the parent model via rollable, not tire
      assert_equal "Giant", tire.rollable.brand
    end
  end
end
