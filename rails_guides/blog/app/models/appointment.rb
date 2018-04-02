class Appointment < ApplicationRecord
  belongs_to :physician
  belongs_to :patient

  has_many :events

  # scope
  # 
  # scopes are similar to class methods except they always returns an
  # ActiveRecord::Relation object, while a class method can return anything
  # you specify. So better to declare them with lambda literal syntax.
  scope :expired, -> { where('appointment_date < ?', Time.now) }
  scope :in_days_of, -> (days) { where('appointment_date between ? and ?', Time.now, (Date.today + days).to_datetime) }

  # default scope
  #   will be appended to every query of the model
  # => SELECT  "appointments".* FROM "appointments" WHERE (1=1)
  #
  #   if the scope argument is given as a hash, like where(active: true),
  #   it will aslo be applied while creating/building a record, which means
  #   the active attribute will be set to true when a new record is being
  #   created or built. To avoid this, use Model.unscoped.new.
  #   unscoped removes all scoping from model crud
  default_scope { where('1=1') }
end
