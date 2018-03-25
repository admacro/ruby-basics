class CreateBicycles < ActiveRecord::Migration[5.1]
  def change
    create_table :bicycles do |t|
      t.string :brand

      t.timestamps
    end
  end
end
