# callback class
# Putting it here for easy lookup, this should be moved out to a separate file.
# 
class CreateUpdateCallbacks
  def before_create(user)
    puts "[callback] [before_create] => #{user.name}"
  end

  # This is different with when you register a callback by proc, see around_save below.
  # Here, you don't need to pass the block, while for around_save, you need to pass an
  # additional parameter (the proc object) to the method.
  #
  # TODO: Need to find out more behind this.
  def around_create(user)
    puts "[callback] [around_create] [before_yield] => #{user.name}"
    yield
    puts "[callback] [around_create] [after_yield] => #{user.name}"
  end
    
  def after_create(user)
    puts "[callback] [after_create] => #{user.name}"
  end

  def self.before_update(user)
    puts "[callback] [before_update] => #{user.name}"
  end
    
  def self.after_update(user)
    puts "[callback] [after_update] => #{user.name}"
  end
end

class User < ApplicationRecord
   
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
#    puts "An object of class #{user.class} is created => #{user.name}"
  end

  after_find do |user|
#    puts "Ah! A record of #{user.class} is found => #{user.name}"
  end

  after_touch do |user|
    puts "Oh! You touched an #{user.class}!!!"
  end

  # callbacks regarding save are always called when create and update is called
  before_save do |user|
    puts "[callback] [before_save] about to save user => #{user.name}"
  end

  # around_save can be understood as a wrapper for save. Inside it, you call yield
  # to invoke the save. You can do things before and after yield is called. So you
  # are coding, working, or calling 'around' the save. With around_save, you can
  # combine before_save and after_save in one callback if you want.
  around_save do |user, save|
    # save is a Proc object dynamically created here
    # #<Proc:0x007f8a3f5d4f50@/Library/Ruby/Gems/2.3.0/gems/activesupport-5.1.5/lib/active_support/callbacks.rb:102>
    puts save
    
    puts "[callback] [around_save] [before yield] saving user => #{user.name}"
    save.yield
    puts "[callback] [around_save] [after yield] saved user => #{user.name}"
  end

  # You can add multiple callbacks to the same callback type
  # For non-transactional callbacks, they will be triggered in their declared order.
  # so below proc will be called first, then :log_something_else
  after_save do |user|
    puts "[callback] [after_save] saved user => #{user.name}"
  end

  after_save :log_something_else
  
  # need to pass an object as the callback methods are instance methods
  # This is useful if you need to access the instance variables of the instance
  #before_create CreateUpdateCallbacks.new
  before_create CreateUpdateCallbacks.new
  around_create CreateUpdateCallbacks.new
  after_create CreateUpdateCallbacks.new

  # no need to create a new object as the callback methods are class methods
  # Usually, we declare the callbacks as class methods if we don't need to
  # access the instance variables.
  before_update CreateUpdateCallbacks
  after_update CreateUpdateCallbacks

  # transactional callbacks are called in reversed order of declaration
  # so :do_data_cleanup will be called before the proc below
  after_commit do
    puts "[callback] [after_commit] Data is saved in database."
  end

  after_commit :do_data_cleanup

  
  # callback methods are better declared private
  private
  
  def callback_before_validation
    puts "[callback] [before_validation]"
  end

  
  def callback_after_validation
    puts "[callback] [after_validation]"
  end

  def log_something_else
    puts "[callback] [after_save] log_something_else => #{self.name}"
  end

  def do_data_cleanup
    puts "[callback] [after_commit] Data clean up."
  end
end

