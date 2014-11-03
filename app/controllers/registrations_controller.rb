class RegistrationsController < ApplicationController

  def new
    @user = User.new
  end

  # def create
  #   @user = User.new
  #   @user.save(params.require(:user)permit.(:email, :password, :password_confirmation))
  #   notice: 'You have been saved'
  #   redirect_to root_path
  # end

end
