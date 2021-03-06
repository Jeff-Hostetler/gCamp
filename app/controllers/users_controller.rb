class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :current_user_can_edit_own_info, only: [:edit, :update, :destroy]


  def index
    @users = User.all
  end

  def show
  end

  def edit
  end

  # GET /users/new
  def new
    @user = User.new
  end

  def create
    if (current_user != nil) && current_user.admin == true
      @user = User.new(params.require(:user).permit(:first_name, :last_name, :email,
      :password, :password_confirmation, :admin, :pivotal_token))
    else
      @user = User.new(user_params)
    end
    if @user.save
      redirect_to users_url, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def update
    if (current_user != nil) && current_user.admin == true
      if @user.update(params.require(:user).permit(:first_name, :last_name, :email, :admin, :pivotal_token))
        redirect_to @user, notice: 'User was successfully updated.'
      else
        render :edit
      end
    else
      if @user.update(params.require(:user).permit(:first_name, :last_name, :email, :pivotal_token))
        redirect_to @user, notice: 'User was successfully updated.'
      else
        render :edit
      end
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email,
    :password, :password_confirmation, :pivotal_token)
  end

  private

  def current_user_can_edit_own_info
    if @user.id == current_user.id || current_user.admin == true
    else
      raise AccessDenied
    end
  end



end
