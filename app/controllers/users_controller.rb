class UsersController < ApplicationController
  def index
    @user = User.new
  end

  def create
    @user = User.create(create_params)

    render text: "OK"
  end

  private
    def create_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
