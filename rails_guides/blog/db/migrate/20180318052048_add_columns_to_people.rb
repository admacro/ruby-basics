class AddColumnsToPeople < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :age, :integer
    add_column :people, :balance, :decimal, precision: 9, scale: 2
  end
end
