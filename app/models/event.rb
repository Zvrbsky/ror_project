# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :host

  has_one_attached :event_image

  validates_presence_of :title, :content, :amount, :event_image
end
