class Comment < ApplicationRecord
  # bin/rails generate model Comment ... article:references
  # :references creates a new column to comment table with name comment_id of
  # type that can hold integer values.
  belongs_to :article

  validates :commenter, presence: true
  validates :body, presence: true

  # as Comment belongs_to Article, when saving an article with comment, callbacks of
  # Comment will also be triggered accordingly, depends on the methods called.
  after_save do |comment|
    puts "#{comment.commenter} added some comment to article '#{self.article.title}'"
  end
end
