# frozen_string_literal: true

# This is responsible for creating books
class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :name
      t.string :author
      t.integer :page_quantity

      t.timestamps
    end
  end
end
