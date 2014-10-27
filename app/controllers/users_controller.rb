class UsersController < ApplicationController

  def index
    @users = User.all
  end

  # GET /tasks/new
  def new
    @users = User.new
  end

  def create
    @user = User.new(event_params)
      respond_to do |format|
        if @user.save
          format.html { redirect_to users_url, notice: 'User was successfully created.' }
        end
      end
  end

  def event_params
      params.require(:user).permit(:first_name, :last_name, :email)
    end

end
