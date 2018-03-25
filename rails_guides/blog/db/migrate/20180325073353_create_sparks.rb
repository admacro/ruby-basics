class CreateSparks < ActiveRecord::Migration[5.1]
  def change
    create_table :sparks do |t|
      t.string :fuel
      t.references :engine, index: true, foreign_key: true

      t.timestamps
    end
  end
end
