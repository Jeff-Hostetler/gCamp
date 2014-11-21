class MembershipsController < ApplicationController

  before_action do
    @project = Project.find(params[:project_id])
  end

  def index
    @memberships = @project.memberships.all
  end

  def create
    @membership = @project.memberships.new(params.require(:membership).permit(:project_id, :user_id, :role))
    if @membership.save
      redirect_to project_memberships_path, notice: "#{@membership.user.full_name} was added successfully"
    else
      render :index
    end
  end

  def edit
    @membership = @project.memberships.find(params[:id])
  end

  def update
    @membership = @project.memberships.find(params[:id])
    if @membership.update(params.require(:membership).permit(:project_id, :user_id, :role))
      redirect_to project_memberships_path, notice: "#{@membership.user.full_name} was updated successfully"
    else
      render :index
    end
  end

  def destroy
    @membership = @project.memberships.find(params[:id])
    @membership.destroy
    redirect_to project_memberships_path, notice: "#{@membership.user.full_name} was deleted successfully"
  end



end
