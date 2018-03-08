class CreateTrains < ActiveRecord::Migration[5.1]
  def change
    # create_table(table_name, comment: nil, **options)
    create_table :trains, comment: "This is a complex table" do |t|
      # It's highly recommended to specify comments in migrations
      
      # A primary key called id will be created by default. To change the name
      # of the PK, override it using `:primary_key` option, and update the 
      # corresponding model accordingly. 
      # Use `id: false` option if you don't want a PK.
      
      t.string :manufacturer, null: false
      t.integer :seats
      t.string :type

      t.timestamps
      # this will add two columns to the schema:
      #   t.datetime "created_at", null: false
      #   t.datetime "updated_at", null: false
    end
  end
end
