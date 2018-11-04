class AddAmountToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :amount, :integer
  end
end
