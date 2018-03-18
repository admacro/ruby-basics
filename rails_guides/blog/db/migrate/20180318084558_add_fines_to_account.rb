class AddFinesToAccount < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :fines, :decimal
  end
end
