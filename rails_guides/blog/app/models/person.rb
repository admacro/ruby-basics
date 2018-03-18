class Person < ApplicationRecord
  validates :name, length: { minimum: 2, too_short: "your name is really strange."}
  validates :bio, length: { maximum: 100, too_long: "you are full of yourself. %{count} is maximum allowed."}
  validates :password, length: { in: 6..20, too_long: "how can you remember password this long.", too_short: "you password is too short to be secure."}
  validates :ssn, length: { is: 18, message: "are you from China?"}

  # By default, numericality doesn't allow nil. Use allow_nil: true to permit it.
  validates :age, numericality: {only_integer: true} # no floating point number
  validates :balance, numericality: true # you can further restrict the format using other options like :greater_than, :equal_to, :odd, etc.
end
