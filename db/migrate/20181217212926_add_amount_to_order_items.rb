class AddAmountToOrderItems < ActiveRecord::Migration[5.2]
  def change
    add_column :order_items, :amount, :int
  end
end
