# coding: utf-8
# ruby

class Article < ApplicationRecord
  # ApplicationRecord inherits from ActiveRecord::Base

  # things to validate before saving to DB
  #
  # if validation fails, expect the following output in server console
  # => begin transaction
  # => rollback transaction
  #
  # default error messages
  #   Title can't be blank
  #   Title is too short (minimum is 5 characters)
  validates :title, presence: true, length: { minimum: 5 }

end
