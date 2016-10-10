class AddWrapStatusToClient < ActiveRecord::Migration[5.0]
  def change
    add_column :clients, :wrap_status, :integer
  end
end
