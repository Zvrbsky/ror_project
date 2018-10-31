# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :user

  validates_presence_of :title
  validates_presence_of :content
end
