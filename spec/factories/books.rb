# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    name { Faker::Book.title }
    author { Faker::Book.author }
    page_quantity { Faker::Number.between(from: 1, to: 1000) }
  end
end
