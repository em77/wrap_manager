class CreateClients < ActiveRecord::Migration[5.0]
  def change
    create_table :clients do |t|
      t.string :name
      t.belongs_to :user, index: true, unique: true, foreign_key: true,
        optional: true
      t.timestamps
    end
  end
end
