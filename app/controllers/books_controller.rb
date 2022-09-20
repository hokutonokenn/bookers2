class BooksController < ApplicationController


  def create
    @book = Book.new(book_params)

    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id)
    else
      @books=Book.all
      @user = current_user
      render :index
    end
  end

  def index
    @books=Book.all
    @book = Book.new
    @user = current_user
  end

  def show
  end

  def edit
    if current_user
      @book = Book.find(params[:id])
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
