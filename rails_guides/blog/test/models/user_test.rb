require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def new_user_attr
    {
     :name => "James",
     :age => 33,
     :occupation => "Code Artist",
     :email => "james@admacro.xyz",
     :email_confirmation => "james@admacro.xyz",
     :eula => true
    }
  end

  def new_user
    User.new(new_user_attr)
  end
  
  test "should not save" do
    new_user
    db_user = User.find_by(name: "James")
    assert_nil db_user
  end

  test "should save" do
    user = new_user
    assert user.save

    db_user = User.find(user.id)
    assert_equal user, db_user
  end

  test "should create" do
    user_attr = {name: "Russell",
                 occupation: "Happy Genius",
                 age: 6,
                 eula: true,
                 email: "russell@haha.com",
                 email_confirmation: "russell@haha.com"
                }
    user = User.create(user_attr)
    db_user = User.find(user.id)
    assert_equal user, db_user
  end

  test "should get all users" do
    users = User.all
    assert_equal 5, users.size
  end

  test "should return all students" do
    students = User.where(occupation: "Student")
    students.each do |s|
      assert_equal "Student", s.occupation
    end
  end

  test "tom should be the oldest" do
    oldest = User.order(age: :desc).first
    assert_equal "Tom", oldest.name
    assert_equal 40, oldest.age
  end

  test "should update the name of user1" do
    user = User.find_by(name: "user1")

    # before update, confirmation field (email here) and acceptance field (eula here)
    # need to be populated to avoid validation error.
    #
    # Rails should do the population automatically but it doesn't. This could be proposed probably?
    # Need to find out more about persistence, validation and how they work together.
    user.email_confirmation = user.email
    user.eula = true
    user.update(name: "Parry")
    parry = User.find_by(name: "Parry")
    assert_equal parry, user
  end

  test "should not save without name" do
    infant = User.new(age: 1, occupation: "Infant")
    saved = infant.save
    assert_not saved
  end

  test "should raise error when save! without name" do
    infant = User.new(age: 1, occupation: "Infant")
    assert_raises ActiveRecord::RecordInvalid do
      infant.save!
    end
  end

  test "should appear as touched" do
    user = User.find_by(name: "user1")
    before_touch = user.updated_at
    user.touch
    user = User.find_by(name: "user1")
    after_touch = user.updated_at
    assert after_touch > before_touch
  end

  
  # ActiveRecord validations
  
  test "should be valid" do
    # create method will call validation before saving the object to DB
    valid = User.create(new_user_attr).valid?
    assert valid
  end

  test "should be invalid" do
    invalid = User.create(name: nil).invalid?
    assert invalid
  end
  
  test "should not have any error before validation" do
    # new method will not call save therefore won't validate the object
    user = new_user
    assert_empty user.errors
    assert_empty user.errors.messages
  end

  test "should have errors after validation" do
    user = User.new
    user.valid? # you need to call valid? explicitly to validate the object
    assert_not_empty user.errors
    assert_not_empty user.errors.messages
    puts user.errors.messages # all error messages for object user
  end

  test "should return error message for name attribute" do
    user = User.new
    user.valid?
    assert_not_empty user.errors[:name]
    puts "attribute error: #{user.errors[:name]}"
  end

  test "should return details of the validator of the invalid attribute" do
    user = User.new
    user.valid?
    validators = user.errors.details[:name]
    assert_not_empty validators
    puts "error details: #{validators}" # => [{:error=>:blank}]
  end


  # validation helpers
  # acceptance
  test "should not save if both Tos and eula are rejected" do
    user = new_user
    user.eula = false
    user.terms_of_service = false 
    valid = user.valid?
    assert_not valid
  end

  test "should pass Tos validation but not eula validation" do
    user = new_user
    user.eula = false
    user.terms_of_service = true
    valid = user.valid?
    assert_not valid
    assert_not_empty user.errors.messages
    assert_equal 1, user.errors.size
    puts  "acceptance errors: #{user.errors.messages}" # {:eula=>["must be abided"]}
  end

  test "should pass all acceptance validations" do
    user = new_user
    user.terms_of_service = true

    user.eula = 'accepted'
    valid = user.valid?
    assert valid

    user.eula = 'TRUE'
    valid = user.valid?
    assert valid

    user.eula = 'yes'
    valid = user.valid?
    assert valid
    
    user.eula = 'YES'
    valid = user.valid?
    assert_not valid
  end

  # confirmation
  test "should be invalid when email confirmation differs" do
    user = new_user
    user.email_confirmation = "james@admacro.com"
    valid = user.valid?
    assert_not valid
    puts "confirmation errors: #{user.errors.messages}" # => {:email_confirmation=>["doesn't match Email"]}
  end

  test "should be valid when email and confirmation are identical" do
    user = new_user
    valid = user.valid?
    assert valid
  end

  # format (regexp)
  test "should not save if email format is invalid" do
    user = new_user
    email = "invalid@email_address"
    user.email = email
    user.email_confirmation = email
    valid = user.valid?
    messages = user.errors.messages
    assert_not valid
    assert_not_empty messages
    puts "format errors: #{messages}"
  end
end
