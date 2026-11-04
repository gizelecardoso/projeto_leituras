require 'rails_helper'

RSpec.describe 'Books', type: :request do
  describe 'GET /books' do
    # INDEX
  end

  describe 'GET /books/:id' do
    # SHOW
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

        expect(response).to redirect_to(books_path)
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
    # EDIT
  end

  describe 'PATCH /books/:id' do
    # UPDATE
  end

  describe 'DELETE /books/:id' do
    # DESTROY
  end
end
