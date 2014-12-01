class ProjectsController <  ApplicationController
  before_action :set_project, only: [:show, :edit, :update]
  before_action :current_user_has_project_permission, except: [:index]
  # before_action :current_user_is_owner_to_edit, only: [:edit]

  def current_user_has_project_permission
    if @project.memberships.pluck(:user_id).include? current_user.id
      true
    else
      render "public/404"
    end
  end

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

end
