class CreateTestForeignKey < ActiveRecord::Migration[5.1]
  def change
    create_table :test_foreign_keys do |t|
      t.string :name
    end
  end
end
