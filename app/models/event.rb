# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :host

  validates_presence_of :title, :content, :amount
end
