# frozen_string_literal: true

# The class of validations and all things about the model Book
class Book < ApplicationRecord
  searchkick

  validates :name, presence: true
  validates :author, presence: true
  validates :page_quantity, presence: true

  validates :page_quantity, numericality: { only_integer: true, greater_than: 0 }
end
