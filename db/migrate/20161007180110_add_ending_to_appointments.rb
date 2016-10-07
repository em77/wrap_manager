class AddEndingToAppointments < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :ending, :datetime
  end
end
