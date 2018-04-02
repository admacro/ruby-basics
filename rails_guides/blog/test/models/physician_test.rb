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

  # Notice above patients is a method. What's the matter here?
  # If `patients` is a method, where is the name from? It's given by us when we declare
  # the association, like this, has_many :patients
  # So, we are not free to use any name for our associations. This also means, we need
  # to be careful not to cause name collisions when creating our models and associations.
  # For example, `attributes` is aleady defined in ActiveRecord::Base

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

  # join
  test "should join" do
    # select only physicians who have appointments
    #
    # => SELECT DISTINCT "physicians".* FROM "physicians"
    #    INNER JOIN "appointments" ON "appointments"."physician_id" = "physicians"."id"
    #
    # you can add conditions to the join to further filter the results
    #   Physician.joins(:appointments).where(...)
    physicians = Physician.joins(:appointments).distinct
    assert_equal 2, physicians.size
    physicians.each { |p| puts p.inspect }
  end

  test "should include all physicians" do
    physicians = Physician.left_outer_joins(:appointments).distinct
    assert_equal 3, physicians.size
  end

  test "should load physicians with appointments data" do
    # with includes, Rails will loads associated records of the object
    # without incldues, Rails will query DB for each iteration of the loop
    # If you know you are gonna need to access the associated data after,
    # use includes to do eager loading.
    physicians = Physician.includes(appointments: :patient).all
    assert_equal 3, physicians.size
    physicians.each do |p|
      p.appointments.each do |a|
        puts "#{p.name} has an appointment with #{a.patient.name} at #{a.appointment_date}"
      end
    end
  end
  
end
