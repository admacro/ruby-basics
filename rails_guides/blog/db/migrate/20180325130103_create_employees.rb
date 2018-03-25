# rails g model Employee name:string manager:references{index}
# this will generate
#   t.references :manager, index: true, foreign_key: true
#
# when this is migrated to database, the manager_id will be referencing
# id in managers table which does not exist. To fix this, remove the
# `foreign_key: true` option.
class CreateEmployees < ActiveRecord::Migration[5.1]
  def change
    create_table :employees do |t|
      t.string :name
      t.references :manager, index: true

      t.timestamps
    end
  end
end
