require 'test_helper'

class BookTest < ActiveSupport::TestCase

  test "should get book for author" do
    author = Author.where(name: "Bertrand Russell")
    books = Book.where(author: author)
    books.each do |book|
      assert "Bertrand Russell", book.author.name
    end
  end

end
