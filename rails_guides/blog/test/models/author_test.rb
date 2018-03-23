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
end
