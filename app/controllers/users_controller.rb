class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @book = Book.new
  end
  def show
    @my_profile = current_user.id
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
      flash[:update] = 'You have updated user successfully.'
    else
      render :edit
    end
  end
  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end