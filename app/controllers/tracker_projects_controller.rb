class TrackerProjectsController < ApplicationController

  def show
    @pivotal_project = API.new.pivotal_single_project(current_user, params[:id])
    @pivotal_stories = API.new.pivotal_stories(current_user, params[:id])
  end

end
