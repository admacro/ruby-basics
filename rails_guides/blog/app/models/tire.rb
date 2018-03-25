class Tire < ApplicationRecord
  belongs_to :rollable, polymorphic: true
end
