class OrderItem < ApplicationRecord
  belongs_to :event
  monetize :price_cents

  def available?
    (event.amount - amount) >= 0
  end

  def decrease_amount!
    event.decrease_amount_by!(amount)
  end

  def cart_order_item_cost
    amount * event.price
  end

  def not_cart_order_item_cost
    amount * price
  end

  def confirm
    update price: event.price
  end
end
