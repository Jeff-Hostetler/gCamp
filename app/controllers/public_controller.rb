class PublicController < ApplicationController
  skip_before_action :current_user_is_not_nil
end
