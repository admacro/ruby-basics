# coding: utf-8
# ruby

class Article < ApplicationRecord
  # ApplicationRecord inherits from ActiveRecord::Base

  # inverse_of: :article is required for validation of associated comments
  has_many :comments, dependent: :destroy, inverse_of: :article
  
  # things to validate before saving to DB
  #
  # if validation fails, expect the following output in server console
  # => begin transaction
  # => rollback transaction
  #
  # default error messages
  #   Title can't be blank
  #   Title is too short (minimum is 5 characters)
  #
  # presence uses blank? to check if the value is either nil or a blank string.
  # when checking the presence of an associated object, marked_for_destruction? method will be also be used
  validates :title, presence: true, length: { minimum: 5 }

  # validates :archived, presence: true # will not work if value is false
  # 
  # To validate if a boolean field is present, don't use presence since
  # false.blank? is true. This means even the field has a value of false,
  # the validation will not pass which is not what we normally wanted.
  validates :archived, inclusion: { in: [true, false]} # only true or false
  # or use: exclusion: { in: [nil] }

  # this will validate the comments objects (if there are any) using the validation
  # rules specified in Comment class.
  validates_associated :comments

  before_validation do |article|
    article.archived = false
    puts "archived = #{article.archived}"
  end

end
