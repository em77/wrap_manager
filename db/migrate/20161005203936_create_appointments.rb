class CreateAppointments < ActiveRecord::Migration[5.0]
  def change
    create_table :appointments do |t|
      t.datetime :start
      t.belongs_to :client, index: true, unique: true, foreign_key: true
      t.belongs_to :user, index: true, unique: true, foreign_key: true
      t.timestamps
    end
  end
end
