FactoryBot.define do
  factory :category do
    name 'art'
    description { Faker::Lorem.word }
  end
end
