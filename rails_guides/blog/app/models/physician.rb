class Physician < ApplicationRecord

  # in database, appointments table holds the foreign key referencing physician_id
  has_many :appointments

  # :through means that the declaring model can be matched with zero or more 
  # instances of another model by proceeding through a third model (Appointment).
  has_many :patients, :through => :appointments


  # an appointment has many events
  # has_many :through is helpful for setting up "shortcut" for nested has_many associations
  has_many :events, :through => :appointments
end
