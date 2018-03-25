class Engine < ApplicationRecord
  belongs_to :car
  has_one :spark
end
