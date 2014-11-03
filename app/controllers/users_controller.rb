class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # before_save {|user| user.email=user.email.downcase}

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
    respond_to do |format|
    @user = User.new(user_params)
        if @user.save
          format.html { redirect_to users_url, notice: 'User was successfully created.' }
        end
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

end
