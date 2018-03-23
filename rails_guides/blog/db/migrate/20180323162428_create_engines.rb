class CreateEngines < ActiveRecord::Migration[5.1]
  def change
    create_table :engines do |t|
      t.string :engine_number
      t.references :car, index: true, foreign_key: true

      t.timestamps
    end
  end
end
