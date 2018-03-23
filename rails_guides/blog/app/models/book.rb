class Book < ApplicationRecord

  # one-to-one relation
  belongs_to :author

end
