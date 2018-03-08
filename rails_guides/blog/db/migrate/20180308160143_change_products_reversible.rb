class ChangeProductsReversible < ActiveRecord::Migration[5.1]

  # direction:up, for change
  def up
    change_column :products, :price, :decimal, precision: 10, scale: 3
    change_column_null :products, :name, false
  end

  # direction:down, for rollback
  # `bin/rails db:rollback` reverts only the last migration
  # to rollback multiple migrations, provide a STEP parameter to the command:
  # `bin/rails db:rollback STEP=3` will revert the last 3 migrations
  #
  # If you want to redo a rollback with multiple steps, use :redo, like this
  # `bin/rails db:migrate:redo STEP=3`
  # This will migrate back the reverted changes of the last 3 migrations.
  #
  def down
    change_column :products, :price, :decimal, precision: 5, scale: 2
    change_column_null :products, :name, true
  end
  
end
