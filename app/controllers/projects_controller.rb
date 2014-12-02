class ProjectsController <  ApplicationController
  before_action :set_project, only: [:show, :edit, :update]
  before_action :current_user_has_project_permission, except: [:index, :new]
  before_action :current_user_is_owner_to_edit, only: [:edit]

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      Membership.create!(
        user_id: current_user.id,
        project_id: @project.id,
        role: "owner",
      )
      redirect_to project_tasks_path(@project), notice: 'Project successfully created'
    else
      render :new
    end
  end

  def show
  end

  def destroy
    Project.find(params[:id]).destroy
    redirect_to projects_path, notice: 'Project was successfully destroyed.'
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to @project, notice: 'Project was successfully updated.'
    else
      render :edit
    end
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end

  def set_project
    @project = Project.find(params[:id])
  end

  private

  def current_user_has_project_permission
    if @project.memberships.pluck(:user_id).include? current_user.id
      true
    else
      render "public/404", status: :not_found, layout: false
    end
  end

  def current_user_is_owner_to_edit
    current_membership = @project.memberships.where(user_id: current_user.id)
    current_membership.each do |membership|
      if membership.role == "owner"
        true
      else
        render "public/404", status: :not_found, layout: false
      end
    end
  end

end
