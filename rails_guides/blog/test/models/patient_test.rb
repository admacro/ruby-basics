require 'test_helper'

class PatientTest < ActiveSupport::TestCase

  test "should have access to all events for an appointment" do
    jack = Patient.find_by(name: "Jack")
    assert_equal 2, jack.events.size
  end
end
