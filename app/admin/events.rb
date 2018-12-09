# frozen_string_literal: true

ActiveAdmin.register Event do
  permit_params :event_image, :title, :content, :host, :amount, :date, :price, :category

  form do |f|
    f.inputs do
      f.input :event_image
      f.input :title
      f.select(:category, %w[Rock Jazz Pop Punk Hardcore Metal Rave])
      f.input :date
      f.input :content
      f.input :amount
      f.input :price
      f.input :host
    end
    f.actions
  end
end
