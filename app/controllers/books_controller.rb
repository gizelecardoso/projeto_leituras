class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)

    if @book.save!
      flash[:sucess] = t(".success")
      redirect_to books_path
    else
      flash.now[:error] = t(".error")
      new_book_path
    end
  end

  private

  def book_params
    params.require(:book).permit(:name, :author, :page_quantity)
  end
end
