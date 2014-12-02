class TasksController < ApplicationController


  before_action do
    @project = Project.find(params[:project_id])
  end

  before_action :current_user_has_tasks_permission

  # GET /tasks
  # GET /tasks.json
  def index
    # can refactor below by dropping == "specific"
    #
    # also can
    # if params this
    #   @tasks=@task.this
    # if params that
    #   @task= @task.that

    if params[:type] == "all" && params[:sort] == "description"
      @tasks = @project.tasks.order(:description)
    elsif params[:type] == "incomplete" && params[:sort] == "description"
      @tasks = @project.tasks.order(:description).where(complete: false)

    elsif params[:type] == "all" && params[:sort] == "complete"
      @tasks = @project.tasks.order(:complete)
    elsif params[:type] == "complete" && params[:sort] == "complete"
      @tasks = @project.tasks.order(:complete).where(complete: false)

    elsif params[:type] == "all" && params[:sort] == "due"
      @tasks = @project.tasks.order(:due)
    elsif params[:type] == "incomplete" && params[:sort] == "due"
      @tasks = @project.tasks.order(:due).where(complete: false)


    elsif params[:type] == "all"
      @tasks = @project.tasks
    elsif params[:type] == "incomplete"
      @tasks = @project.tasks.where(complete: false)
    else
      @tasks = @project.tasks.where(complete: false)
    end

    respond_to do |format|
      format.html
      format.csv { send_data @tasks.as_csv }
    end


  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = @project.tasks.find(params[:id])
    @comment = Comment.new
  end

  # GET /tasks/new
  def new
    @task = @project.tasks.new
  end

  # GET /tasks/1/edit
  def edit
    @task = @project.tasks.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = @project.tasks.new(task_params)
    if @task.save
      redirect_to project_task_path(@project, @task), notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    @task = @project.tasks.find(params[:id])
    if @task.update(task_params)
      redirect_to project_task_path(@project, @task), notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task = @project.tasks.find(params[:id])
    @task.destroy
    redirect_to project_tasks_path(@project), notice: 'Task was successfully destroyed.'
  end

  private
  
  def current_user_has_tasks_permission
    if @project.memberships.pluck(:user_id).include? current_user.id
      true
    else
      render "public/404", status: :not_found, layout: false
    end
  end
    # Use callbacks to share common setup or constraints between actions.


    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:description, :complete, :due, :project_id)
    end



end
