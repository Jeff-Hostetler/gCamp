class ApplicationController < ActionController::Base
  include SessionsHelper

  before_action :current_user_is_not_nil

  def current_user_is_not_nil
    if current_user != nil
      true
    else
      redirect_to login_path, notice: "You must be logged in to access that action"
    end
  end


end
