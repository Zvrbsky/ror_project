class Order < ApplicationRecord
  belongs_to :owner, polymorphic: true
  has_many :order_items

  scope :pending, -> { where(status: PENDING_STATUS) }

  CART_STATUS = 'cart'.freeze
  PENDING_STATUS = 'pending'.freeze
  COMPLETE_STATUS = 'complete'.freeze
end
