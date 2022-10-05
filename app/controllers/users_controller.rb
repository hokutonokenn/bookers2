class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]
  def ensure_correct_user
  	if current_user.id != params[:id].to_i
  		redirect_to user_path(current_user.id)
  	end
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to book_path(@book.id)
    flash[:success]="You have created book successfully."
  end

  def index
    @users = User.all
    @book = Book.new
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
     @user = User.find(params[:id])
    if @user == current_user
      render :edit
    else
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
        flash[:notice] = "You have update user successfully."
        redirect_to user_path(@user.id)
    else
      render :edit
    end
  end



    private
  def user_params
    params.require(:user).permit(:name,:profile_image,:introduction)
  end
  def book_params
    params.require(:book).permit(:title,:body)
  end


end
