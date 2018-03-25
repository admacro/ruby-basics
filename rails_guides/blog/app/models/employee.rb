class Employee < ApplicationRecord
  # by specifying class name and column name of the foreign key, Rails will
  # get to know that :subordinates are referencing itself.
  #
  # So, here I conjecture that when class_name and foreign_key are not provided,
  # like normally when referencing another model, Rails will figure out the 
  # class_name and foreign_key from the association name, for example, 
  #   `has_many :books` is equal to
  #   `has_many :books, class_name: "Book", foreign_key: "book_id"`
  #
  # More about how Rails looks for the associated objects
  # By default, associations look for objects only within the current module's scope.
  # This can be important when you scope models with modules. So, for example, the
  # following association won't work:
  #   module MyApp
  #     module Biz
  #       class Author < ApplicationRecord
  #         has_many :books
  #       end
  #     end
  #     module BizStore
  #       class Book < ApplicationRecord
  #         belongs_to :author
  #       end
  #     end
  #   end
  #
  # To fix above issue, you need to specify class_name explicitly using class_name option.
  #   has_many :books, class_name: "MyApp::BizStore::Book"
  #   belongs_to :author, class_name: "MyApp::Biz::Author"
  #
  has_many :subordinates, class_name: "Employee", foreign_key: "manager_id"
  belongs_to :manager, class_name: "Employee"
end
