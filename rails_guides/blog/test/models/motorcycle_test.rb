require 'test_helper'

class MotorcycleTest < ActiveSupport::TestCase

  test "should save" do
    vehicles = Vehicle.all
    puts vehicles.inspect
    
    honda = Motorcycle.create(color: "red", price: 3000)
    assert_not_nil honda
  end
end
