class Comment < ApplicationRecord
  # bin/rails generate model Comment ... article:references
  # :references creates a new column to comment table with name comment_id of
  # type that can hold integer values.
  belongs_to :article
end
