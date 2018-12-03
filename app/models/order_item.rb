class OrderItem < ApplicationRecord
  monetize :price_cents
end
