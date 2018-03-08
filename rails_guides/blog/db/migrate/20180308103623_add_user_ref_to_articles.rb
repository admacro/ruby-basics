# bin/rails g migration AddUserRefToArticles user:references{polymorphic}
# 
# user:references{polymorphic} will add a `type` column for belongs_to
# associations besides user_id foreign_key column, and will create an
# index with both columns, like this:
# 
#     t.string "user_type"
#     t.integer "user_id"
#     t.index ["user_type", "user_id"], name: "index_articles_on_user_type_and_user_id"
#
# (check schema.rb for details)
#
class AddUserRefToArticles < ActiveRecord::Migration[5.1]
  def change
    add_reference :articles, :user, polymorphic: true
    # => add_reference(:articles, :user, {:polymorphic=>true})
  end
end
