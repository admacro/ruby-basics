# callback class
# Putting it here for easy lookup, this should be moved out to a separate file.
# 
class CreateUpdateCallbacks
  def before_create(user)
    puts "[callback] [before_create] => #{user.inspect}"
  end
    
  def after_create(user)
    puts "[callback] [after_create] => #{user.inspect}"
  end

  def self.before_update(user)
    puts "[callback] [before_update] => #{user.inspect}"
  end
    
  def self.after_update(user)
    puts "[callback] [after_update] => #{user.inspect}"
  end
end

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
    unless: Proc.new { |user| user.eula}

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
    self.terms_of_service
  end


  ########################################################

  # callbacks
  # let's exploit the UT output, :D

  before_validation :callback_before_validation, on: [:create, :update]
  after_validation :callback_after_validation, on: :update

  # will be triggered whenever a new object of this class is initialized
  # for example, after method :new, :create, :find.
  after_initialize do |user|
    puts "An object of class #{user.class} is created => #{user.inspect}"
  end

  after_find do |user|
    puts "Ah! A record of #{user.class} is found => #{user.inspect}"
  end

  after_touch do |user|
    puts "Oh! You touched an #{user.class}!!!"
  end

  # callbacks regarding save are always called when create and update is called
  before_save do
    puts "[callback] [before_save] using block"
  end
  around_save do
    puts "[callback] [around_save] saving ..."
  end
  after_save  do
    puts "[callback] [after_save] using block"
  end


  # ======== Important Finding ==========
  # Rails seems to ignore callbacks of create and update when callbacks of save are
  # found in the callback queue. I commented out the callbacks above (of save) and
  # then the following callbacks of create and update worked immediately.
  # This may be a bug or a feature. Need to find out more.
  # ======== Important Finding ==========
  
  # need to pass an object as the callback methods are instance methods
  # This is useful if you need to access the instance variables of the instance
  #before_create CreateUpdateCallbacks.new
  before_create CreateUpdateCallbacks.new
  after_create CreateUpdateCallbacks.new

  # no need to create a new object as the callback methods are class methods
  # Usually, we declare the callbacks as class methods if we don't need to
  # access the instance variables.
  before_update CreateUpdateCallbacks
  after_update CreateUpdateCallbacks

  after_commit do
    puts "Data is saved in database. Now tell user he's all set."
  end

  # callback methods are better declared private
  private
  
  def callback_before_validation
    puts "[callback] [before_validation]"
  end

  
  def callback_after_validation
    puts "[callback] [after_validation]"
  end
    
end

