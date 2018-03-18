class AddMultiColumnIndexToAccounts < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :domain, :string
    add_index :accounts, [:subdomain, :domain], unique: true
  end
end
