class AddColumnToAppointments < ActiveRecord::Migration[5.1]
  def change
    add_column :appointments, :lock_version, :integer
  end
end
