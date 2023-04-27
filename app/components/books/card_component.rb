# frozen_string_literal: true

module Books
  # Component responsible for render the informations of the Book in the list of Books
  class CardComponent < ViewComponent::Base
    attr_reader :book

    with_collection_parameter :book

    def initialize(book:)
      super # rubocop Lint/MissingSuper
      @book = book
    end
  end
end
