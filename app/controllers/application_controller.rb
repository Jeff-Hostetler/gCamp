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

  class AccessDenied < StandardError
  end

  rescue_from AccessDenied, with: :access_denied

  def access_denied
    render "public/404", layout: false, status: 404
  end

end
