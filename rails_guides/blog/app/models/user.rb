class User < ApplicationRecord
  attr_accessor :terms_of_service, :eula
  
  validates :name, presence: true

  # field with acceptance validation must be set to non-nil value, otherwise
  # the validation won't be triggered
  #
  # acceptance validation is very specific to web applications so you don't
  # need to have it recorded in your database, although you can. However, if 
  # you have a corresponding column for an acceptance field, then you must set 
  # :accept option to true or include true in the allowed values.
  #
  # :unless
  # apply this validation unless user.eula is true (= if user.eula is false). 
  # can take a method as :if below
  validates :terms_of_service,
    acceptance: true,
    unless: Proc.new { |user| user.eula == "Yes"}

  # all values in :accept option are considered as valid
  # use :message to customize the error message, default is "must be accepted"
  #
  # :if
  # apply this validation if tos_accepted? returns true.
  # can take a Proc object as :unless above
  validates :eula,
    acceptance: {
                 accept: [true, 'TRUE', 'Yes', 'accepted', 'yes'],
                 message: 'must be abided'
                },
    if: :tos_accepted?

  # will validate a virtual field named email_confirmation
  validates :email,
    confirmation: true,
    format: {
             with: /[a-z0-9]+@[a-z0-9]+\.[a-z0-9]+/,
             message: "email format is not valid"
            }

  # this is for validation only, no column is needed for this.
  # naming convention is Xxx_confirmation
  # confirmation will only be triggered when the value is not nil, hence a
  # presence validation must be added
  validates :email_confirmation, presence: true 

  def tos_accepted?
    :terms_of_service
  end

  
end

