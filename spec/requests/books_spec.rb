require 'rails_helper'

RSpec.describe 'Books', type: :request do
  describe 'GET /books' do
    let!(:books) { create_list(:book, 3) }

    it 'returns a successful response' do
      get books_path

      expect(response).to have_http_status(:ok)
    end

    it 'displays the books' do
      get books_path

      books.each do |book|
        expect(response.body).to include(book.name)
      end
    end
  end

  describe 'GET /books/:id' do
    let(:book) { create(:book) }

    it 'returns a successful response' do
      get book_path(book)

      expect(response).to have_http_status(:ok)
    end

    it 'displays the book details' do
      get book_path(book)

      expect(response.body).to include(book.name)
      expect(response.body).to include(book.author)
    end

    context 'when the book does not exist' do
      it 'raises a record not found error' do
        expect {
          get book_path(id: 999999)
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'GET /books/new' do
		it 'returns a successful response' do
			get new_book_path

			expect(response).to have_http_status(:ok)
		end

		it 'renders the new book form' do
			get new_book_path

			expect(response.body).to include('form')
		end
	end

  describe 'POST /books' do
    context 'with valid parameters' do
      let(:valid_params) do
        {
          book: attributes_for(:book)
        }
      end

      it 'creates a new book' do
        expect {
          post books_path, params: valid_params
        }.to change(Book, :count).by(1)
      end

      it 'redirects to the created book' do
        post books_path, params: valid_params

        expect(response).to redirect_to(book_path(Book.last))
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        {
          book: attributes_for(:book, name: nil)
        }
      end

      it 'does not create a book' do
        expect {
          post books_path, params: invalid_params
        }.not_to change(Book, :count)
      end

      it 'returns an unprocessable entity status' do
        post books_path, params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
	end

  describe 'GET /books/:id/edit' do
    it 'returns a successful response' do
      book = create(:book)
      get edit_book_path(book)

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PATCH /books/:id' do
    context 'with valid parameters' do
      let(:book) { create(:book) }
      let(:valid_params) do
        {
          book: { name: 'Updated Book Name'}
        }
      end

      it 'updates the book' do
        patch book_path(book), params: valid_params

        expect(book.reload.name).to eq('Updated Book Name')
      end

      it 'redirects to the book' do
        patch book_path(book), params: valid_params

        expect(response).to redirect_to(book_path(book))
      end
    end

    context 'with invalid parameters' do
      let(:book) { create(:book) }
      let(:invalid_params) do
        {
          book: { name: '' }
        }
      end

      it 'does not update the old book' do
        patch book_path(book), params: invalid_params

        expect(book.name).not_to eq('')
      end

      it 'returns an unprocessable entity status' do
        patch book_path(book), params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /books/:id' do
    context 'when the book exists' do
      let!(:book) { create(:book) }

      it 'deletes the book' do
        expect { delete book_path(book) }.to change(Book, :count).by(-1)
      end

      it 'redirects to the books index' do
        delete book_path(book)

        expect(response).to redirect_to(books_path)
      end
    end

    context 'when the book does not exist' do
      it 'raises a record not found error' do
        expect {
          delete book_path(id: 999999)
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'GET /books with search' do
    let(:search_term) { 'Harry Potter' }

    let(:external_books) do
      [
        build(
          :book, 
          name: 'Harry Potter and the Philosopher Stone', 
          author: 'J.K. Rowling', 
          page_quantity: 309
        )
      ]
    end

    let(:google_books_api) do
      instance_double(GoogleBooks::Api)
    end

    before do
      allow(GoogleBooks::Api)
        .to receive(:new)
        .and_return(google_books_api)

      allow(google_books_api)
        .to receive(:get_books)
        .with(search_term)
        .and_return(external_books)
    end

    it 'displays books returned by the Google Books API' do
      get books_path, params: { search: search_term }

      expect(response).to have_http_status(:ok)
      expect(response.body).to include(external_books.first.name)
    end
  end    
end
