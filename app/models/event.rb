# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :host
  has_one_attached :event_image
  validates_presence_of :title, :content, :amount, :date
  validates :event_image, attached: true

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
end
