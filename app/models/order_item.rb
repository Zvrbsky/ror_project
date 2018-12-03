class OrderItem < ApplicationRecord
  belongs_to :event
  monetize :price_cents
end
