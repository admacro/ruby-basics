class Truck < ApplicationRecord

  has_many :tires, as: :rollable
end
