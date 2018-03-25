require 'test_helper'

class PhysicianTest < ActiveSupport::TestCase
  
  # Other methods available to instancs of Physician model (provided by has_many).
  # 
  # patients
  # patients<<(object, ...)
  # patients.delete(object, ...)
  # patients.destroy(object, ...)
  # patients=(objects)
  # patient_ids
  # patient_ids=(ids)
  # patients.clear
  # patients.empty?
  # patients.size
  # patients.find(...)
  # patients.where(...)
  # patients.exists?(...)
  # patients.build(attributes = {}, ...)
  # patients.create(attributes = {})
  # patients.create!(attributes = {})
  # patients.reload
  test "should load all patients for Dr. Stephen" do
    physician = Physician.find_by(name: "Dr. Stephen")
    assert_equal 2, physician.patients.size
    assert_equal 2, physician.appointments.size
  end

  test "should reconnect patients" do
    stephen = Physician.find_by(name: "Dr. Stephen")
    new_patient = Patient.new(name: "Tony")

    # the xxxx=(object) method resets the associated models in database by creating new
    # records (if not exist) and deleting missing records.
    # This is a rather dangerous method as it performe these actions sliently. I'd suggest
    # to give it a more prompting method name.
    stephen.patients = [new_patient]
    
    assert_equal 1, stephen.patients.size
  end
  
end
