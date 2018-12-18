class AddPriceToOrderItems < ActiveRecord::Migration[5.2]
  def change
    add_column :order_items, :price, :money
  end
end
