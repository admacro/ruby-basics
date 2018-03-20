require 'test_helper'

class ProductTest < ActiveSupport::TestCase

  test "should not be valid for preorder products" do
    product = Product.new(name: "preorder xbox game of throne VII")
    assert_not product.valid?

    messages = product.errors.full_messages
    assert_not_empty messages

    puts messages
  end

  test "should not be valid for promotion products" do
    product = Product.new(name: "Sales buy one TV get a free TV stand",
                          description: "This product is for promotion. But it's shit.")
    assert_not product.valid?

    messages = product.errors.full_messages
    assert_not_empty messages

    puts messages
  end
  
end
