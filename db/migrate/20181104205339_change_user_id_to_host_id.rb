class ChangeUserIdToHostId < ActiveRecord::Migration[5.2]
  def change
    rename_column :events, :user_id, :host_id
  end
end
