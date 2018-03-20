require 'test_helper'

# Minitest is the default testing library used by Rails.
#
# run this test with `bin/rails test test/models/article_test.rb`
# to run all tests, use `bin/rails test`
# to run a particular test method, provide the -n (--name) flag and the method
#   name: `bin/rails test test/models/article_test.rb -n test_the_truth`
#
# Notice the 'F' in the output when there is a test failure
# Notice the 'E' in the output when there is an error with the code

# Notes
# 
# the execution of a test method stops as soon as any error or assertion 
# failure is encountered and the test suite continues with the next method.
#
# All test methods are executed in random order. You can configure this with 
# config.active_support.test_order_option in config/environments/test.rb.

# Assertions
# Two sets of assertions are available, one from Minitest and one Rails provides
# You can alse write your own assertion.
#
# other common assertions from Minitest:
# - assert_equal => expected == actual
# - assert_not_equal => expected != actual
# - assert_same => expected.equal? actual is true
# - assert_not_same => expected.equal? actual is false
# - assert_nil => obj.nil? is true
# - assert_not_nil => obj.nil? is false
# - flunk(msg) => Ensures failure. This is useful to explicitly mark a test
#                 that isn't finished yet. Same as assert(false, msg).
# ...

class ArticleTest < ActiveSupport::TestCase
  # ActiveSupport::TestCase inherits Minitest::Test

  # A test method begins with test_ (case sensitive).
  #
  # With Rails, use a method called test that takes a test name and a block to
  # test your code so we don't need to worry about the naming issue.
  # For example:
  test "the truth" do
    puts "using Rails test method to test"
    assert true
  end
  
  # The above is the same as:
  # def test_the_truth # note uncommenting this will override the method above 
  #   puts "using Minitest:Unit to test" 
  #   assert true
  # end

  # testing Article model
  test "should not save article without title" do
    article = Article.new

    # custom message when the test fails, default is "Excepted ... to be ..."
    assert_not article.save, "Saved the article without a title"
  end

  # a test with error (E)
  test "should report error" do
    some_undefined_variable
    assert true
  end

  # To pass a test with error, use assert_raises
  #
  # assert_raises is useful when you deliberately want an error to be raised 
  # for a test case.
  test "should not report error" do
    assert_raises(NameError) do
      another_undefined_variable
    end
  end


  # validation test
  # validates_associated
  test "should not save article if comments are invalid" do
    article = Article.new
    article.title = "Washington News"
    article.archived = false

    comment = Comment.new
    comment.commenter = "James"

    article.comments << comment

    valid = article.valid?
    assert_not valid
    
    p article.errors.messages # => {:comments=>["is invalid"]}
    p comment.errors.messages # => {:body=>["can't be blank"]}

    # error messages in comment do not bubble up to the calling model
    # default error message for the associated attribute is "is invalid"
  end

  test "should save article with comments" do
    article = Article.new
    article.title = "Book Review - Ruby on Rails"
    article.archived = false
    
    comment = Comment.new
    comment.commenter = "James"
    comment.body = "I like this book."

    article.comments << comment

    valid = article.save
    assert valid
  end

  # boolean presence
  test "should not pass validation for archived field" do
    article = Article.new
    article.title = "Breaking news"
    
    # leave archived unset here
    assert_not article.valid?

    # will fail either if archived is set to nil
    article.archived = nil
    assert_not article.valid?
    
    messages = article.errors.messages
    assert_not_empty messages
    puts "Boolean presence: #{messages}"
    # => Boolean presence: {:archived=>["is not included in the list"]}
  end

  test "should pass validation for archived field" do
    article = Article.new
    article.title = "Breaking news"
    article.archived = false
    assert article.valid?
    assert_empty article.errors.messages
  end
end
