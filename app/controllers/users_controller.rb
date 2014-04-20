class UsersController < ApplicationController
  def index
    if session[:user_id]
      redirect_to posts_path
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(create_params)

    if @user.save
      redirect_to posts_path
    else
      render :index
    end
  end

  def sign_in
    @user = User.find_by(email: params[:user][:email]).try(:authenticate, params[:user][:password])
    if @user
      session[:user_id] = @user.id
      redirect_to posts_path
    else
      @user = User.new
      render :index
    end
  end

  private
    def create_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
