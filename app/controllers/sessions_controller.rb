class SessionsController < PublicController

  def new
  end

  def login
    user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        session[:user_id] = user.id
        if session[:request_path] !=nil
          redirect_to session[:request_path]
        else
          redirect_to projects_path
        end
      else
        @login_error = "Incorrect email/password combination."
        render :new
      end
  end

  def logout
    session.delete(:user_id)
    session.delete(:request_path)
    @current_user = nil
    redirect_to root_path
  end

end
