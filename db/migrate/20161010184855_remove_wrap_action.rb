class RemoveWrapAction < ActiveRecord::Migration[5.0]
  def change
    remove_column :client_actions, :wrap_action
  end
end
