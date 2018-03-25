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
end
