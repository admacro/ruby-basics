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
