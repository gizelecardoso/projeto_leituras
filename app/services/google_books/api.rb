module GoogleBooks
  class Api
    include HTTParty

    BASE_URI = "https://www.googleapis.com/books/v1"

    attr_reader :api_key

    def initialize(api_key: Rails.application.credentials.google_api_key)
      @api_key = api_key
    end

    def get_books(search_by)
      puts 'Conectando na API do Google'
      response = self.class.get("#{BASE_URI}/volumes?q=#{search_by}&key=#{api_key}")
      prepare_data(response['items'])
    end

    private

    def prepare_data(items)
      books = []
      volume = items.map { |reason| reason['volumeInfo'] }
      volume.each do |volumeInfo|
        books << Book.new(
          name: volumeInfo['title'],
          author: volumeInfo['authors']&.first,
          page_quantity: volumeInfo['pageCount']
        )
      end
      books
    end
  end
end
