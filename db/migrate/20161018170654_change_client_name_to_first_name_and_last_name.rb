class ChangeClientNameToFirstNameAndLastName < ActiveRecord::Migration[5.0]
  def change
    remove_column :clients, :name
    add_column :clients, :first_name, :string
    add_column :clients, :last_name, :string
  end
end
