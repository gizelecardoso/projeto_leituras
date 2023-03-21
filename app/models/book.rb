class Book < ApplicationRecord
  validates :name, presence: true
  validates :author, presence: true
  validates :page_quantity, presence: true

  validates :page_quantity, numericality: { only_integer: true, greater_than: 0 }
end
