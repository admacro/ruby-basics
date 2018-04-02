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

  # optimistic locking using additional column, default name is lock_version,
  # you can change it using self.locking_column = :super_locking_name in model
  # class definition.
  test "should fail to update for patient" do
    jane = Physician.find_by(name: "Dr. Jane")
    a_physician = jane.appointments.take

    jack = Patient.find_by(name: "Jack")
    appointments = jack.appointments.select {|a| a.id == a_physician.id}
    a_patient = appointments.first

    # method `tomorrow` is from ActiveSupport, not in Ruby's std library.
    # this is equivalent to Date.today.next_day in standard Ruby, in
    # which case you need to require 'date' first
    a_physician.update(appointment_date: Date.tomorrow)

    # => ActiveRecord::StaleObjectError: Attempted to update a stale object: Appointment.
    a_patient.update(appointment_date: Date.tomorrow.tomorrow)
  end

  # pessimistic lock, aka row-level db lock. (db dependent)
  #   select ... for update (not supported by sqlite3)
  #
  # use method `lock` to lock a model object
  test "should lock" do
    # start a transaction and then aquire a lock
    Appointment.transaction do
      # => select * from appointments limit 1 for update
      # lock supports raw SQL for a different type of db lock, for instance, with mysql,
      # you can write lock('lock in share mode') to lock a row for writing but still
      # allow reading from other queries
      a = Appointment.lock.first
      a.appointment_date = Date.tomorrow
    end
    
    # start a transaction and aquire a lock in one go
    a = Appointment.first
    a.with_lock do
      # a is already locked at this point
      a.update(appointment_date: Date.tomorrow)
    end
  end

  # scope
  test "should scope" do
    expired = Appointment.expired
    assert_not_empty expired
    assert_equal 2, expired.size
    expired.each { |a| puts a.appointment_date }

    in_three_days = Appointment.in_days_of(4)
    assert_equal 1, in_three_days.size
    in_three_days.each { |a| puts a.appointment_date }
  end
end
