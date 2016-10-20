class CreateMonthlyStats < ActiveRecord::Migration[5.0]
  def change
    create_table :monthly_stats do |t|
      t.integer :total_wrap_sessions
      t.integer :unique_clients_attended_wrap_sessions
      t.integer :total_wraps_opened
      t.integer :total_wraps_completed
      t.integer :unique_clients_attended_non_wrap
      t.integer :total_non_wrap
      t.integer :year
      t.integer :month

      t.timestamps
    end
  end
end
