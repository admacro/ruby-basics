require 'test_helper'

class EmployeeTest < ActiveSupport::TestCase

  test "should have the correct hierarchy" do
    robin = Employee.find_by(name: "Robin");
    assert_equal 2, robin.subordinates.size

    james = Employee.find_by(name: "James")
    assert_equal 2, james.subordinates.size
    assert_equal robin, james.manager
  end

end
