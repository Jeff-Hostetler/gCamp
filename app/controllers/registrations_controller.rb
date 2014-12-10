class RegistrationsController < PublicController

  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:email, :password, :password_confirmation,
    :first_name, :last_name, :pivotal_token))
    if @user.save
      session[:user_id] = @user.id
      redirect_to new_project_path
    else
      @signup_error = true
      render :new
    end
  end

end
