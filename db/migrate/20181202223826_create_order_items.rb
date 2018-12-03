class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.integer :order_id
      t.integer :event_id
      t.monetize :price

      t.timestamps
    end
  end
end
