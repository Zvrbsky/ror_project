FactoryBot.define do
  factory :event do
    title { Faker::Games::Fallout.character }
    content { Faker::Games::Fallout.quote }
    amount { Random.rand(100) }
    date { Faker::Date.forward(Random.rand(100)) }
    category { %w[Rock Jazz Pop Punk Hardcore Metal Rave].sample }
    price { Random.rand(100) }
    association :host
  end
end
