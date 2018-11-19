# frozen_string_literal: true

ActiveAdmin.register Event do
  permit_params :event_image, :title, :content, :host_id, :amount, :date
  form partial: 'form'
end
