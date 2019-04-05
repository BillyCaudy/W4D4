class UsersController < ApplicationController
  before_action :require_no_user!, only: [:new, :create]
  def create
    @user = User.new(user_params)
    if @user.save!
      login_user!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  private
  
  def user_params
    params.require(:user).permit(:password, :email)
  end
end
