# try to run bin/rails db:rollback after db:migrate will give the following error:
# 
# Caused by:
# ActiveRecord::IrreversibleMigration: 
#
# This migration uses remove_columns, which is not automatically reversible.
# To make the migration reversible you can either:
# 1. Define #up and #down methods in place of the #change method.
# 2. Use the #reversible method to define reversible behavior.
# 
class ChangeProducts < ActiveRecord::Migration[5.1]
  def change
    change_table :products do |t|
      t.remove :part_number # this calls remove_column which is not reversible
      t.index :name
      t.string :brand
      t.boolean :grocery
    end

    change_column :products, :price, :decimal, precision: 6, scale:3
  end
end
