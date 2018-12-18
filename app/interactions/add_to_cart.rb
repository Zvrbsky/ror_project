class AddToCart < ActiveInteraction::Base
  object :guest
  object :event

  def execute
    ordered_event = guest.cart.find_order_item_by_event(event)
    if ordered_event.present?
      ordered_event.amount += 1
      ordered_event.save
    else
      guest.cart.order_items.create event: event, amount: 1
    end
  end
end
