class Order < ApplicationRecord
  belongs_to :owner, polymorphic: true
  has_many :order_items
end
