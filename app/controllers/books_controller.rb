# frozen_string_literal: true

# Controlador das ações CRUD do modelo de Livros
class BooksController < ApplicationController
  def index
    @books = params[:title].blank? ? Book.search('*') : Book.search(params[:title])

    # @books = params[:search] ? search_books : Book.all
  end

  def search_books
    ::GoogleBooks::Api.new.get_books(params[:search])
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)

    if @book.save!
      flash[:sucess] = t('.success')
      redirect_to books_path
    else
      flash.now[:error] = t('.error')
      new_book_path
    end
  end

  private

  def book_params
    params.require(:book).permit(:name, :author, :page_quantity, :title)
  end
end
