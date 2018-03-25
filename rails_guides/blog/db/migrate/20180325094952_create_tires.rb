# rails g model Tire size:integer 'rollable:references{polymorphic,index}'
# Notice the single quote around the column definition. If you need multiple
# type modifiers, the whole definition must be single quoted.
#
class CreateTires < ActiveRecord::Migration[5.1]
  def change
    create_table :tires do |t|
      t.integer :size

      # will create two columns plus one index
      # "rollable_type" varchar, "rollable_id" integer
      # "index_tires_on_rollable_type_and_rollable_id" ON "tires" ("rollable_type", "rollable_id")
      t.references :rollable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
