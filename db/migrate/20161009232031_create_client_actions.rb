class CreateClientActions < ActiveRecord::Migration[5.0]
  def change
    create_table :client_actions do |t|
      t.integer :wrap_session
      t.string :wrap_action
      t.text :notes
      t.string :user_name
      t.integer :client_id
      t.timestamps
    end
  end
end
