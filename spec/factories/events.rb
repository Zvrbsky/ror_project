FactoryBot.define do
  factory :event do
    title { Faker::Fallout.character }
    content { Faker::Fallout.quote }
    amount {Random.rand(100)}
    date {Faker::Date.forward(Random.rand(100))}
    association :host
  end
end