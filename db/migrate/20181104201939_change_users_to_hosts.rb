class ChangeUsersToHosts < ActiveRecord::Migration[5.2]
  def change
    rename_table :users, :hosts
  end
end
