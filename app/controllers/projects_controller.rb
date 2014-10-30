class ProjectsController <  ApplicationController

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_param)
    @project.save
    redirect_to projects_path
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end

end