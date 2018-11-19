# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'uri'

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
Host.create!(email: 'top@kek.com', password: '123456')
Host.create!(email: 'top2@kek.com', password: '123456')

10.times do
  event = Event.create!(host_id: Faker::Number.between(1, 2),
                        title: Faker::Cannabis.cannabinoid,
                        content: Faker::Games::Fallout.quote,
                        amount: Faker::Number.number(2),
                        date: Faker::Date.forward(1000))
  bl = true
  while bl
    begin
      file = open(URI.parse(Faker::Avatar.image))
      bl = false
    rescue OpenURI::HTTPError
    end
  end
  event.event_image.attach(io: file, filename: 'dummy.png')
  event.save
end