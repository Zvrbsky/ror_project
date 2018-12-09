class AddToCart < ActiveInteraction::Base
  object :guest
  object :event

  def execute
    guest.cart.order_items.create event: event
  end
end
