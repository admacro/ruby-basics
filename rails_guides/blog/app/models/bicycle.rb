class Bicycle < ApplicationRecord

  has_many :tires, as: :rollable
  
end
