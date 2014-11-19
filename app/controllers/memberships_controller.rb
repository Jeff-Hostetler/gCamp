class MembershipsController < ApplicationController

  before_action do
    @project = Project.find(params[:project_id])
  end

  def index
    @memberships = Membership.all
  end

  def form_new
    @membership = Membership.new
  end

  def create
    @membership = Membership.new(params.require[:membership].permit(:project_id, :user_id))
    if @membership.save
      redirect_to projects_path
    else
      render :index
    end
  end

  def edit
    @membership = Membership.find(params[:id])
  end

  def update
    @membership = Membership.find(params[:id])
    if @membership.update(params.require[:membership].permit(:project_id, :user_id))
      redirect_to projects_path
    else
      render :index
    end
  end

  def destroy
    Membership.find(params[:id]).destoy
  end

  

end
