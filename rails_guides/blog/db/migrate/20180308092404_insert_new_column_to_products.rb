# To add new column to a table using `bin/rails gererate migration` command,
# use AddXxxToYyy followed by a list of columns and types.
#
# The following won't work as it doesn't follow the naming convention
# bin/rails g migration InsertNewColumnToProducts supplier:reference{polymorphic}
# Though you can keep the name and modify it manually, it is not recommanded by Rails.
#
# should be something like this:
# bin/rails g migration AddSupplierToProducts supplier:reference{polymorphic}
class InsertNewColumnToProducts < ActiveRecord::Migration[5.1]
  def change
    # nothing will be made to the DB
  end
end
