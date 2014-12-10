class TrackerProjectsController < ApplicationController

  def show
      @pivotal_stories = API.new.pivotal_tracker_stories(current_user, params[:id])
  end

end
