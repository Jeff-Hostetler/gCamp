class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :current_user_can_edit_own_info, only: [:edit, :update]

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
    @user = User.new(user_params)
    if @user.save
      redirect_to users_url, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_url, notice: 'user was successfully updated.'}
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.'}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

  def user_params
      params.require(:user).permit(:first_name, :last_name, :email,
      :password, :password_confirmation)
  end

  private

  def current_user_can_edit_own_info
    if @user.id == current_user.id
    else
      render "public/404", status: :not_found, layout: false
    end
  end

end
