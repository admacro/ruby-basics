require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  test "should be invalid if subdomain is reserved" do
    account = Account.create(subdomain: "us")
    invalid = account.invalid?
    messages = account.errors.messages
    assert invalid
    assert_not_empty messages
    p messages # => {:subdomain=>["us is reserved.", "us is not a subdomain"]}
  end

  test "should not pass if subdomain is not listed" do
    account = Account.create(subdomain: "xzy")
    invalid = account.invalid?
    messages = account.errors.messages
    assert invalid
    assert_not_empty messages
    p messages # => {:subdomain=>["xzy is not a subdomain"]}
  end
  
  test "should be valid if subdomain is listed but not reserved " do
    account = Account.create(subdomain: "blog")
    valid = account.valid?
    assert valid
  end
end
