# frozen_string_literal: true

module GoogleBooks
  # Class responsible for configuring conexion to API Google Books and return data of books based on a research
  class Api
    include HTTParty

    BASE_URI = 'https://www.googleapis.com/books/v1'

    attr_reader :api_key

    def initialize(api_key: ENV.fetch('GOOGLE_API_KEY'))
      @api_key = api_key
    end

    def get_books(search_by)
      logger = Rails.logger
      logger.info 'Conectando na API do Google'
      response = self.class.get("#{BASE_URI}/volumes?q=#{search_by}&key=#{api_key}")
      prepare_data(response['items'])
    end

    private

    def prepare_data(items)
      books = []
      volume = items.pluck('volumeInfo')
      volume.each do |volume_info|
        books << Book.new(
          name: volume_info['title'],
          author: volume_info['authors']&.first,
          page_quantity: volume_info['pageCount']
        )
      end
      books
    end
  end
end
