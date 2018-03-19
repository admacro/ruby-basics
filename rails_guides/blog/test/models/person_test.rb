require 'test_helper'

class PersonTest < ActiveSupport::TestCase

  def new_person_attr
    {
     name: "James",
     bio: "I'm a code artisan.", 
     password: "123abc$$$",
     ssn: "3206831985XXXXXXXX",
     age: 32,
     balance: 100 # This guy doesn't save :p
    }
  end

  test "should pass validation" do
    person = Person.new(new_person_attr)
    valid = person.valid?
    assert valid
  end

  test "should not pass validation" do
    attr_hash = {
                 name: "a",
                 bio: %q(I'm a troll.I'm a troll.I'm a troll.I'm a troll.I'm a troll.I'm a troll.
                 I'm a troll.I'm a troll.I'm a troll.I'm a troll.I'm a troll.I'm a troll.
                 I'm a troll.I'm a troll.I'm a troll.I'm a troll.I'm a troll.I'm a troll.), 
                 password: "tg9023*$)ent2)>nu2)().@^!@$",
                 ssn: "12345678oppsXXXXXXXX",
                 age: "38.5", # I try to be as accurate as possible :D
                 balance: "$100,000"
                }
    person = Person.new(attr_hash)
    valid = person.valid?
    assert_not valid
    messages = person.errors.messages
    assert_not_empty messages
    puts "Invalid person object: #{messages}"

    # default messages:
    # => Invalid person object: {:name=>["is too short (minimum is 2 characters)"], :bio=>["is too long (maximum is 100 characters)"], :password=>["is too short (minimum is 6 characters)"], :ssn=>["is the wrong length (should be 18 characters)"]}

    # custom messages :D
    # Invalid person object: {:name=>["your name is really strange."], :bio=>["you are full of yourself. 100 is maximum allowed."], :password=>["how can you remember password this long."], :ssn=>["Hey a, are you a Person from China? Your Ssn's length is 12345678oppsXXXXXXXX . It should have 18 numbers."], :age=>["must be an integer"], :balance=>["is not a number"]}

    # Note that the default error messages are plural (e.g., minimum is 1 charatcers).
    # For this reason, when :minimum is 1 you should provide a custom message or use presence:true prior to length
  end

  test "should validate ssn on create but not on update" do
    person = Person.create(new_person_attr)
    valid = person.valid?
    assert valid

    person_change = new_person_attr
    person_change[:ssn] = nil
    person_change[:age] = 20
    
    valid = person.update(person_change)
    assert valid

    db_person = Person.find(person.id)
    assert_equal 20, db_person.age
    assert_nil db_person.ssn
  end
end
