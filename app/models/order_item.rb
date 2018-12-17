class OrderItem < ApplicationRecord
  belongs_to :event
  monetize :price_cents

  def available?
    (event.amount - amount) >= 0
  end

  def decrease_amount!
    event.decrease_amount_by!(amount)
  end
end
