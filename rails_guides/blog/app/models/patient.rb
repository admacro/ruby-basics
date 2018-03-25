class Patient < ApplicationRecord

  has_many :appointments
  has_many :physicians, :through => :appointments

  has_many :events, :through => :appointments
end
