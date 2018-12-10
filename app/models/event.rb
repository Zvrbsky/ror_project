# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :host
  has_one_attached :event_image
  validates_presence_of :title, :content, :amount, :date
  monetize :price_cents

  def self.search(search)
    if search
      where('title LIKE ?', "%#{search}")
    else
      all
    end
  end

  def self.filter(cat)
    if cat == 'All'
      all
    else
      where('category LIKE ?', "%#{cat}")
    end
  end

  def self.decrease_ticket_number(order)
    events = Event.order_to_hash_of_events(order)
    events.each do |event_id, amount|
      return false if (Event.find_by_id(event_id).amount - amount).negative?
    end
    events.each do |event_id, amount|
      event = Event.find_by_id(event_id)
      event.amount -= amount
      event.save
    end
    true
  end

  def self.order_to_hash_of_events(order)
    events = Hash.new(0)
    order.order_items.all.each do |item|
      events[item.event_id] += 1
    end
    print(events)
    events
  end
end
