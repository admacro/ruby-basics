require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def new_user
    user = User.new
    user.name = "James"
    user.age = 33
    user.occupation = "Code Artist"
    user.eula = true
    user.email = "james@admacro.xyz"
    user.email_confirmation = "james@admacro.xyz"
    user
  end
  
  test "should not save" do
    user = new_user
    db_user = User.find_by(name: "James")
    assert_not_equal user, db_user
  end

  test "should save" do
    user = new_user
    user.save
    db_user = User.find_by(name: "James")
    assert_equal user, db_user
  end

  test "should create" do
    user_attr = {name: "Russell",
                 occupation: "Happy Genius",
                 eula: true,
                 email: "russell@haha.com",
                 email_confirmation: "russell@haha.com"
                }
    user = User.create(user_attr)
    db_user = User.find_by(occupation: "Happy Genius")
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
    user.update(name: "Parry", email_confirmation: user.email, eula: true)
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

  
  # ActiveRecord validations
  
  test "should be valid" do
    # create method will call validation before saving the object to DB
    valid = User.create(new_user).valid?
    assert valid
  end

  test "should be invalid" do
    invalid = User.create(name: nil).invalid?
    assert invalid
  end
  
  test "should not have any error before validation" do
    # new method will not call save therefore won't validate the object
    user = User.new
    assert_empty user.errors
    assert_empty user.errors.messages
  end

  test "should have errors after validation" do
    user = User.new
    user.valid? # you need to call valid? explicitly to validate the object
    assert_not_empty user.errors
    assert_not_empty user.errors.messages
    p user.errors.messages # => {:name=>["can't be blank"]}
  end

  test "should return error message for name attribute" do
    user = User.new
    user.valid?
    assert_not_empty user.errors[:name]
    p user.errors[:name]
  end

  test "should return details of the validator of the invalid attribute" do
    user = User.new
    user.valid?
    validators = user.errors.details[:name]
    assert_not_empty validators
    p validators # => [{:error=>:blank}]
  end


  # validation helpers
  # acceptance
  test "should not save if ToS is rejected" do
    user = new_user
    user.terms_of_service = false 
    valid = user.valid?
    assert_not valid
  end

  test "should skip Tos validation but not pass eula validation" do
    user = new_user
    user.eula = 'no' 
    valid = user.valid?
    assert_not valid
    assert_not_empty user.errors.messages
    assert_equal 1, user.errors.size
    p user.errors.messages # {:eula=>["must be abided"]}
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
    p user.errors.messages # => {:email_confirmation=>["doesn't match Email"]}
  end

  test "should be valid when email and confirmation are identical" do
    user = new_user
    valid = user.valid?
    assert valid
  end

end
