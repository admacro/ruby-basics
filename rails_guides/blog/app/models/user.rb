class User < ApplicationRecord
  validates :name, presence: true

  # field with acceptance validation must be set to non-nil value, otherwise
  # the validation won't be triggered
  #
  # acceptance validation is very specific to web applications so you don't
  # need to have it recorded in your database, although you can. However, if 
  # you have a corresponding column for an acceptance field, then you must set 
  # :accept option to true or include true in the allowed values.
  validates :terms_of_service, acceptance: true

  # all values in :accept option are considered as valid
  # use :message to customize the error message, default is "must be accepted"
  validates :eula, acceptance: { accept: [true, 'TRUE', 'Yes', 'accepted', 'yes'], message: 'must be abided'}

  validates :email, confirmation: true
  validates :email_confirmation, presence: true # confirmation will only be triggered when the value is not nil, hence a presence validation must be added
end

