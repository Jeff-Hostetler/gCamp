class SessionsController < ApplicationController

  def new
    user = User
  end

  def login
    user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        session[:user_id] = user.id
        redirect_to user
      else
        flash[:notice] = 'Incorrect password and/or email. Please try again.'
        render :new
      end
  end

  def logout
    session.delete(:user_id)
    @current_user = nil
    redirect_to root_path
  end

end
