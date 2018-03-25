require 'test_helper'

class AppointmentTest < ActiveSupport::TestCase

  test "should have a physicians and a patient in each appointment" do
    appointments = Appointment.all
    assert_equal 3, appointments.size

    appointments.each do |appointment|
      assert_not_nil appointment.physician
      assert_not_nil appointment.patient
    end
  end

end
