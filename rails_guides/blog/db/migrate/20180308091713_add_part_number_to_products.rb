# bin/rails g migration AddPartNumberToProducts part_number:string:index
#
# The naming pattern is AddXxxToYyy. Examples:
# bin/rails g migration AddColumnNameToProducts column_name:column_type
# bin/rails g migration AddOneColumnToProducts column_name:column_type
# bin/rails g migration AddMoreColumnsToProducts column_name1:column_type1 column_name2:column_type2 ...
#
# Note!
# PartNumber in the class name serves only informative purpose, it won't be used
# for column name interpretation as you might have guessed. Instead, you need to
# provide a list of column names and types for Rails to be able to know what to
# add to the table. Without column info, the change method will be empty.
# 
# However, when your migration is a bit complex, you may want to write your own 
# change method in which case generating a migration skeleton will be sufficient.
# And in that case, you don't need to follow the naming convention.
# For example, bin/rails g migration FixProductionDataIssue
#
class AddPartNumberToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :part_number, :string
    # => add_column(:products, :part_number, :string)
    
    add_index :products, :part_number
    # => add_index(:products, :part_number)
  end
end
