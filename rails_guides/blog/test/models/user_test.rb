require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def new_user
    user = User.new
    user.name = "James"
    user.age = 33
    user.occupation = "Code Artist"
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
    user = User.create(name: "Russell", occupation: "Happy Genius")
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
end
