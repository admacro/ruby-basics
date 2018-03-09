# It seems that when you create a table, and you have a column you need to
# reference it to another table, Rails will add the foreign key constraint
# only when you use `rails g model CreateArticle ... user:references`. If you
# create a migration first or create the model without references, later when
# try to add it by add_reference(..., foreign_key: true) will now create a
# proper foreign key constrait in the DB.
#
# This is currently my assumption. Need to dig deeper to confirm the issue.
#
class AddFkToTestForeignKeys < ActiveRecord::Migration[5.1]
  def change
    add_reference :test_foreign_keys, :author, foreign_key: true
  end
end
