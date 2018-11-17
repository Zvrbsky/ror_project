FactoryBot.define do
  factory :host do
    email { Faker::Internet.email}
    password { '123456' }
  end
end