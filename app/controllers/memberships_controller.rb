class MembershipsController < ApplicationController

  before_action do
    @project = Project.find(params[:project_id])
  end

  before_action :current_user_has_membership_permission
  before_action :current_user_is_owner_to_edit, except: [ :destroy]
  before_action :current_user_can_delete_self, only: [ :destroy]


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
    if @project.memberships.where(role: "owner").count < 2
      redirect_to project_memberships_path, notice: "Sorry, you need at least one admin in this project"
    else
      @membership = @project.memberships.find(params[:id])
      if @membership.update(params.require(:membership).permit(:project_id, :user_id, :role))
        redirect_to project_memberships_path, notice: "#{@membership.user.full_name} was updated successfully"
      else
        render :index
      end
    end
  end

  def destroy
    @membership = @project.memberships.find(params[:id])
    if @project.memberships.where(role: "owner").count < 2
      redirect_to project_memberships_path, notice: "Sorry, you need at least one admin in this project"
    else
      @membership.destroy
      if @project.memberships.pluck(:user_id).include? current_user.id
        redirect_to project_memberships_path, notice: "#{@membership.user.full_name} was deleted successfully"
      else
        redirect_to projects_path, notice: "#{@membership.user.full_name} was deleted successfully"
      end
    end
  end

  private

  def current_user_can_delete_self
    current_membership = @project.memberships.where(user_id: current_user.id)
    current_membership.each do |membership|
      unless membership.role.empty? && current_user.admin == false
        @can_delete = true
      end
    end
  end

  def current_user_has_membership_permission
    if (@project.memberships.pluck(:user_id).include? current_user.id) || (current_user.admin == true)
      true
    else
      raise AccessDenied
    end
  end

  def current_user_is_owner_to_edit
    current_membership = @project.memberships.where(user_id: current_user.id)
    current_membership.each do |membership|
      @membership_role = membership.role
      if (membership.role == "owner")
        @current_membership = true
      else
        @current_membership = false
      end
    end
  end

end
