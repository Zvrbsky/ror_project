# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :host

  has_one_attached :event_image

  def self.search(search)

    if search
      where('title LIKE ?', "%#{search}")
    else
      all
    end
  end

  def self.filter(cat)
    if cat == 'All'
      Event.all
    else
      where('category LIKE ?', "%#{cat}")
    end
  end

  validates_presence_of :title, :content, :amount, :event_image, :date
end
