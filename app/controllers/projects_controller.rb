class ProjectsController <  ApplicationController
  before_action :set_project, only: [:show, :edit, :update]

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.save
    redirect_to @project, notice: 'Project successfully created'
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
    @project.update(project_params)
    redirect_to @project, notice: 'Project was successfully updated.'
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end

  def set_project
    @project = Project.find(params[:id])
  end

end
