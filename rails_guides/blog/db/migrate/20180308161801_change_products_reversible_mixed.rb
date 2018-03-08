class ChangeProductsReversibleMixed < ActiveRecord::Migration[5.1]
  def change
    reversible do |dir|
      change_table :products do |t|
        dir.up {
          t.change :price, :string
          t.remove :grocery
        }
        dir.down {
          t.change :price, :integer
          t.boolean :grocery
        }
      end
    end
  end
end
