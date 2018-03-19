class Person < ApplicationRecord
  validates :name, length: { minimum: 2, too_short: "your name is really strange."}

  # a String :message can contain %{model}, %{attribute}, and %{value} 
  validates :bio, length: { maximum: 100, too_long: "you are full of yourself. %{count} is maximum allowed."}
  validates :password, length: { in: 6..20, too_long: "how can you remember password this long.", too_short: "you password is too short to be secure."}

  # custom message using a block
  validates :ssn,
    length: { is: 18,
             message: -> (person, data) do
               %(Hey #{person.name}, are you a #{data[:model]} from China? Your #{data[:attribute]}'s length is #{data[:value]} . It should have %{count} numbers.)
             end
             # message can take a Proc object with two arguments:
             #   1. the object being validated
             #   2. a hash with :model, :attribute and :value
            },
    
  # when to apply this validation, another option is :update. If not set, validates on both (default).
  # you can also specify a custom context, for example, `on: :account_setup`. In this case, you will have to trigger
  # the validation manually by calling `valid?(:account_setup)`.
  # Note that this will only validate the object without saving the model.
  on: :create, 

  # this option will cause Rails to raise an runtime error when validation fails.
  # The default error is ActiveModel::StrictValidationFailed.
  # You can specify your own custom error, like this:
  # `strict: SsnValidationFailedException`
  strict: true

  # if you have multiple validations that need to be triggered when one condition 
  # is met, instead of adding the same condition to each validation, group them 
  # together usuing `with_options`.
  #
  # with_options is not only useful for validation grouping, but also useful when 
  # you need to pass an option to multiple method calls.
  # Check http://api.rubyonrails.org for details.
  with_options if: :male? do |man|    
    # By default, numericality doesn't allow nil. Use allow_nil: true to permit it.
    man.validates :age, numericality: {only_integer: true} # no floating point number
    
    # you can further restrict the format using other options like :greater_than, :equal_to, :odd, etc.
    man.validates :balance, numericality: true 
  end

  def male?
    true
  end
end
