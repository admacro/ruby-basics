require 'test_helper'

class AuthorTest < ActiveSupport::TestCase

  test "should create a new book for the author" do
    name = "Abelson and Sussman"
    author = Author.create(name: name)
    book = author.books.create(title: "SICP", published_at: Time.now)
    assert book.id > 0
    assert_equal name, book.author.name
  end

  test "should delete all books when deleting author" do
    russell = "Bertrand Russell"
    
    author = Author.find_by(name: russell)
    author_id = author.id
    author.destroy

    book = Book.find_by(author_id: author_id)
    assert_nil book
  end

  # bi-directional association
  #
  # NOTE: associations with scope, :through, or :foreign_key are not identified as
  #       bi-directional. To fix this, use :inverse_of option on the "other side" of
  #       belongs_to.
  # For example:
  #   has_many :books, inverse_of: 'writer'
  #   has_many :patients, through: :appointments, inverse_of: 'physician'
  #
  test "should load one copy of the author" do
    russell = "Bertrand Russell"
    author = Author.find_by(name: russell)

    # In bi-directional association, Rails will only load one copy of the Author object
    book = author.books.first
    author.name = "Russell"
    assert_equal author.name, book.author.name
  end

  # this method alone is not very useful as you can only pass one attribute to the method.
  # In real world, objects usually have more than one attribute, to create a valid record,
  # the object must pass various validations.
  #
  # To make it useful, we can use create_with, or pass a block to it.
  #   Author.create_with(xxx: xxx, yyy: yyy).find_or_create_by(zzz: zzz)
  #   Author.find_or_create_by(zzz: zzz) do |a|
  #     a.xxx = xxx
  #     a.yyy = yyy
  #     ...
  #   end
  # 
  test "should create if not found" do
    name = 'Parry'
    parry = Author.find_or_create_by(name: name)
    assert_not_nil parry
    assert_equal name, parry.name
  end

  test "should find by sql" do
    authors = User.find_by_sql('select * from authors')
    assert_equal 2, authors.size
  end

end
