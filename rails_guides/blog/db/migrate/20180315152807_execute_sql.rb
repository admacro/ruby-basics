# When APIs are not enough you can fallback to SQL.
# but you need to write your own rollback method if you want it to be reversible, 
# you can use #up and #down methods for this.
#
# For example:
# def up
#   execute <<-SQL
#     ...
#   SQL
# end
class ExecuteSql < ActiveRecord::Migration[5.1]
  def change
    # Option 1:
    # Comment.connection.execute("update comments set body = '<removed>' where 1 = 1")

    # Option 2:
    # this will print the SQL when migrated
    execute <<-SQL
      update comments set body = '<removed>' where 1 = 1;
    SQL
  end
end
