class Order < ApplicationRecord
  belongs_to :owner, polymorphic: true
  has_many :order_items

  scope :pending, -> { where(status: PENDING_STATUS) }

  CART_STATUS = 'cart'.freeze
  PENDING_STATUS = 'pending'.freeze
  COMPLETE_STATUS = 'complete'.freeze

  def items_available?
    order_items.all?(&:available?)
  end

  def decrease_tickets_amount!
    order_items.each(&:decrease_amount!)
  end

  def find_order_item_by_event(event)
    result = order_items.select do |item|
      item.event_id == event.id
    end
    result[0]
  end

  def size
    size = 0
    order_items.each { |item| size += item.amount }
    size
  end

  def order_cost
    cost = 0
    if status == CART_STATUS
      order_items.each { |item| cost += item.cart_order_item_cost }
    else
      order_items.each { |item| cost += item.not_cart_order_item_cost }
    end
    cost
  end

  def confirm
    order_items.each(&:confirm)
    update status: PENDING_STATUS
  end
end
