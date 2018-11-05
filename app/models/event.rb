# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :host

  has_one_attached :event_image
  has_one_attached :event_thumb
  validates_presence_of :title, :content, :amount
end
