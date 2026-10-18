# frozen_string_literal: true

# Controlador das ações CRUD do modelo de Livros
class BooksController < ApplicationController
  before_action :set_book, only: %i[edit update show destroy]

  def index
    @books = params[:search] ? search_books : Book.all
  end

  def search_books
    ::GoogleBooks::Api.new.get_books(params[:search])
  end

  def show
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

  def edit
  end

  def update
    if @book.update(book_params)
      flash[:sucess] = t('.success')
      redirect_to books_path
    else
      flash.now[:error] = t('.error')
      edit_book_path
    end
  end

  def destroy
    if @book.destroy
      flash[:sucess] = t('.success')
      redirect_to books_path
    else
      flash.now[:error] = t('.error')
      redirect_to books_path
    end
  end

  private

  def book_params
    params.require(:book).permit(:name, :author, :page_quantity)
  end

  def set_book
    @book = Book.find(params[:id])
  end
end
