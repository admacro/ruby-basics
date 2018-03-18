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

  test "should not pass validation if any fine is present" do
    account = Account.new(subdomain: "admin", fines: 5000)
    assert_not account.valid?

    messages = account.errors.messages
    assert_not_empty messages
    puts messages # => {:fines=>["must be blank"]}
  end

  test "should not save duplicate account" do
    account = Account.create(subdomain: "admin", domain: "rails")
    assert account.valid?

    d_account = Account.create(subdomain: "admin", domain: "rails")
    messages = d_account.errors.messages
    assert_not_empty messages
    puts messages # => {:domain=>["should be only one per subdomain"]}
  end

  test "should save accounts with same subdomain but different domains" do
    account = Account.create(subdomain: "admin", domain: "ruby")
    assert account.valid?

    n_account = Account.create(subdomain: "admin", domain: "rails")
    assert n_account.valid?
    messages = n_account.errors.messages
    assert_empty messages

    accounts = Account.where(subdomain: "admin")
    assert_not_empty accounts
    assert_equal 2, accounts.size
    puts accounts.inspect
    # => <ActiveRecord::Relation [#<Account id: 980190964, subdomain: "admin", domain: "rails", created_at: "2018-03-18 10:12:46", updated_at: "2018-03-18 10:12:46", fines: nil>, #<Account id: 980190963, subdomain: "admin", domain: "ruby", created_at: "2018-03-18 10:12:46", updated_at: "2018-03-18 10:12:46", fines: nil>]>
  end
end
