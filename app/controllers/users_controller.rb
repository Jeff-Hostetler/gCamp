class UsersController < ApplicationController

  def index
    @users = User.all
  end

  # GET /users/new
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
      respond_to do |format|
        if @user.save
          format.html { redirect_to users_url, notice: 'User was successfully created.' }
        end
      end
  end

  def user_params
      params.require(:user).permit(:first_name, :last_name, :email)
  end

end
