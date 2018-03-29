# rails generate model vehicle type:string color:string price:decimal{10.2}
# Notice the type modifier is passed as decimal{10.2} without single quote
class CreateVehicles < ActiveRecord::Migration[5.1]
  def change
    create_table :vehicles do |t|
      t.string :type
      t.string :color
      t.decimal :price, precision: 10, scale: 2

      t.timestamps
    end
  end
end
