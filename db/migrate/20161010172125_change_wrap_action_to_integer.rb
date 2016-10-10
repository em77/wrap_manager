class ChangeWrapActionToInteger < ActiveRecord::Migration[5.0]
  def change
    remove_column :client_actions, :wrap_action
    add_column :client_actions, :wrap_action, :integer
  end
end
