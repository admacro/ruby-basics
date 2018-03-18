require 'test_helper'

class ProductTest < ActiveSupport::TestCase

  test "should not be valid for preorder products" do
    product = Product.new(name: "preorder xbox game of throne VII")
    assert_not product.valid?

    messages = product.errors.messages
    assert_not_empty messages

    puts messages
    # => {:base=>["This is a preorder product."], :name=>["must start with upper case"]}
  end

  test "should not be valid for promotion products" do
    product = Product.new(name: "Sales buy one TV get a free TV stand",
                            description: "This product is for promotion")
    assert_not product.valid?

    messages = product.errors.messages
    assert_not_empty messages

    puts messages # => {:description=>["description has promotion info"]}
  end
  
end
