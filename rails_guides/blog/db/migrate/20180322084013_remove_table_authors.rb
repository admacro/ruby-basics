class RemoveTableAuthors < ActiveRecord::Migration[5.1]
  def change
    drop_table :authors
  end
end
