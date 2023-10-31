# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    name { 'O Senhor dos Anéis: A Sociedade do Anel' }
    author { 'J.R.R. Tolkien' }
    page_quantity 576
  end
end
