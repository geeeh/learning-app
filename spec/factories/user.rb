# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    username { Faker::Name.word }
    email { Faker.internet.email }
    password '123123123'
  end
end
