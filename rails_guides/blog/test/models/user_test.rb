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


  # query interface
  #
  # Finder methods that return a collection, such as where and group, return an
  # instance of ActiveRecord::Relation. Methods that find a single entity, such
  # as find and first, return a single instance of the model.
  #
  test "should take records from db" do
    # generates SQL:
    #   SELECT * FROM users LIMIT 1
    # returns nil if no record found
    user = User.take # take 1 (default) record from db
    assert_not_nil user
    puts "Query take => #{user.inspect}"

    # take 3
    # generates SQL:
    #   SELECT * FROM users LIMIT 3
    users = User.take(3)
    user_count = User.take(4).count
    assert_equal 3, users.size
    assert_equal 4, user_count
    puts "Query take => #{users.inspect}"
  end

  # first
  test "should find the first of all records ordered by id" do
    # generates SQL:
    #   SELECT * FROM users ORDER BY users.id ASC LIMIT 1
    # returns nil if no record found
    user = User.first # gets the first 1 (default) record from db
    assert_not_nil user
    puts "Query first => #{user.inspect}"

    # last 2 order by name in descent order
    # generates SQL:
    #   SELECT * FROM users ORDER BY users.id DESC LIMIT 2
    users = User.order(:name).last(2)
    assert_equal 2, users.size
    puts "Query first => #{users.inspect}"
  end

  test "should get the same record for find_by and where" do
    # generates SQL:
    #   SELECT * FROM users ORDER BY users.id ASC LIMIT 1
    # returns nil if no record found
    user1 = User.find_by name: "Tom"
    user2_relation = User.where(:name => "Tom")
    assert_not_equal user1, user2_relation # different class of object

    puts "user1.class => #{user1.class}" # => User
    puts "user2_relation.class => #{user2_relation.class}" # => User::ActiveRecord_Relation
    
    assert_equal user1, user2_relation.take # use take to get the first record
  end

  test "should batch process all records" do
    # Rails gets all the data in users table, creates an object for each row, 
    # and stores all the objects in memory. This approach becomes increasingly
    # impractical as the table size increases, but usually should be ok if total 
    # number of records is around a thousand.
    User.all.each do |user|
      # processing user data ...
      # for example, send each user a newsletter
      assert_not_nil user
      puts user.inspect
    end

    # find_each retrieves users in batches of 1000 and yields them to the block one by one.
    # you can change the batch size to a smaller or larger value depend on your table size.
    # 
    # find_each also works on relations, for example:
    #   User.where('age > 20').find_each(batch_size: 5000) do |user| ... end
    #
    # check API for other options, such as :start, :finish, :error_on_ignore
    User.find_each do |user|
      assert_not_nil user
    end

    # find_in_batches yields batches to the block as an array of models
    User.find_in_batches do |users| # note the type of the block parameter is Array
      assert_equal 5, users.size
    end
  end

  # Building your own conditions as pure strings can leave you vulnerable to SQL injection exploits.
  # like this:
  #   User.where('age > #{param[:age]}')
  test "should find by conditions" do
    # Array condition - one condition
    users = User.where('age > ?', 25)
    users.each do |user|
      assert user.age > 25
    end

    # Array condition - multiple conditions
    users = User.where('age > ? and occupation = ?', 21, 'Student')
    users.each do |user|
      assert user.age > 21
      assert_equal 'Student', user.occupation
    end

    # placeholder conditions - using Hash
    users = User.where('age > :age and occupation = :occupation', {age: 20, occupation: 'Student'})
    users.each do |user|
      assert user.age > 20
      assert_equal 'Student', user.occupation
    end

    # Hash condition
    users = User.where(occupation: 'Student')
    users.each do |user|
      assert_equal 'Student', user.occupation
    end

    # range condition
    # generates SQL:
    #   SELECT * FROM users WHERE (users.age BETWEEN 25 AND 40)
    users = User.where(age: (25..40))
    users.each do |user|
      assert user.age >= 25
      assert user.age <= 40
    end

    # subset condition (in (...))
    # generates SQL:
    #   SELECT * FROM users WHERE users.age IN (20, 21)
    users = User.where(age: [20, 21])
    users.each do |user|
      assert user.age == 20 || user.age == 21
    end

    # NOT condition ( != )
    # generates SQL:
    #   SELECT * FROM users WHERE (users.occupation != 'Student')
    users = User.where.not(occupation: 'Student')
    users.each do |user|
      assert_not_equal 'Student', user.occupation
    end

    # OR condition ( or )
    # generates SQL:
    #   SELECT * FROM users WHERE (users.occupation == 'Student' OR users.age > 35)
    #
    # NOTICE the parameter of `or` method
    #   .or('age > ?', 35) will not work
    users = User.where(occupation: 'Student').or(User.where('age > ?', 35))
    users.each do |user|
      assert (user.occupation == 'Student' || user.age > 35)
    end
  end

  test "should be in order" do
    # order by age asc (default)
    users = User.order(:age)
    youngest = users.min {|u1, u2| u1.age <=> u2.age}
    assert_equal youngest, users.first

    # order by multiple columns
    #
    # Note
    # columns in ascending order should have :asc declared explicitly if they are not
    # the first ordering parater. For example, User.order(occupation: :desc, :age) will
    # not work, but User.order(:age, occupation: :desc) works. However, you can call
    # order method multiple times to overcome this to make code cleaner, like this:
    users = User.order(occupation: :desc).order(:age)
    youngest = users.min {|u1, u2| u1.age <=> u2.age}
    assert_equal youngest, users.first
  end

  test "should select names only" do
    users = User.select(:name).where.not(occupation: 'Student')
    users.each do |user|
      # age attribute does not even exist
      # => ActiveModel::MissingAttributeError: missing attribute: age
      # assert_nil user.age
      
      assert_nil user.id
      assert_not_empty user.name
      puts user.inspect # => #<User id: nil, name: "Jin Bao">
    end
  end

  test "should select distinct email addresses" do
    # => ActiveModel::MissingAttributeError: missing attribute: name
    # Cause: in callbacks of User model, user.name is called. Check user.rb for details.
    # Solution: disable callbacks of after_initialize and after_find.
    users = User.select(:email).distinct
    assert_equal 3, users.size
    users.each {|u| puts u.email}
  end

  test "should get 2 records only and from 3rd row" do
    users = User.limit(2).offset(2)
    users.each {|u| puts u.email}
  end

  # group with having
  #
  # other overriding conditions besides unscope are:
  #   only => only(:order, :where)
  #   rewhere => overrides where
  #   reorder => overrides order
  #   reverse_order => reverses the order specified if exists, otherwise orders
  #     by id descending order
  test "should group by email" do
    users = User.select('distinct occupation, max(age) as age, email').group(:email).having('age < ?', 30).unscope(:having)
    users.each {|u| puts u.email}
  end


  # none
  def special_users(occupation)
    if not occupation.empty?
      User.where(occupation: occupation)
    else
      # none makes chaining possible after the call of this method (special_users)
      # as returning nil or [] will break the caller code
      User.none # => returns an empty Relation and fires no queries 
    end
  end
  
  test "should chain" do
    user_count = special_users("").where('age > ?', 25).count
    assert_equal 0, user_count
 
    user_count = special_users("Student").where('age < ?', 22).count
    assert_equal 2, user_count
  end


  # readonly
  #
  # => ActiveRecord::ReadOnlyRecord: User is marked as readonly
  test "should be readonly" do
    new_email = "new_address@school.com"
    students = User.readonly.where(occupation: "Student")
    students.each do |s|
      s.email = new_email
      s.email_confirmation = s.email # this is checked first, before checking readonly attribute
      s.save
      assert_not_equal new_email, s.email
    end
  end


  # dynamic finders
  #   find_by_<attribute_name>
  # 
  # examples:
  #   find_by_year(1985)
  #   find_by_archived!(false)
  #   find_by_first_name("James")
  test "should find by name" do
    tom = User.find_by_name("Tom")
    assert_not_nil tom
    assert_equal "Driver", tom.occupation
  end


  # pluck
  #   query single or multiple columns
  test "should get all names of users" do
    # => SELECT "users"."age" FROM "users"
    names = User.pluck(:name)
    assert_not_empty names
    names.each {|n| puts n}

    # => SELECT "users"."id", "users"."name", "users"."age" FROM "users"
    # returns results in two-dimentional array
    #   [[298486374, "Jin Bao", 27], [338193910, "user0", 20], ... ]
    users = User.pluck(:id, :name, :age)
    assert_not_empty users
    users.each {|n| p n}
  end

  test "should calculate" do
    min = User.minimum(:age)
    max = User.maximum(:age)
    avg = User.average(:age)
    sum = User.sum(:age)
    puts "minimal age of all users is #{min}"
    puts "maximal age of all users is #{max}"
    puts "average age of all users is #{avg}"
    puts "sum of all users' age is #{sum}"
  end  
end
