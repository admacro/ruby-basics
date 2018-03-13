# It seems that when you create a table, and you have a column you need to
# reference it to another table, Rails will add the foreign key constraint
# only when you use `rails g model CreateArticle ... user:references`. If you
# create a migration first or create the model without references, later when
# try to add it by add_reference(..., foreign_key: true) will not create a
# proper foreign key constrait in the DB.
#
# This is currently my assumption. Need to dig deeper to confirm the issue.
#
# Update:
# Issue confirmed, but only with sqlite3 database. Tried with MySql without
# any problem. So, this depends on the database. See this thread for more information:
# https://stackoverflow.com/questions/1884818/how-do-i-add-a-foreign-key-to-an-existing-sqlite-table
#
class AddUserRefToComment < ActiveRecord::Migration[5.1]
  def up
    change_table :comments do |t|
      t.references :user, foreign_key: true
    end
  end

  def down
    change_table :comments do |t|
      t.remove_references :user
    end
  end
end
