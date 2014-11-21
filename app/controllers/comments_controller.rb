class CommentsController < ApplicationController

  before_action do
    @project = Project.find(params[:project_id])
    @task = Task.find(params[:task_id])
  end

  def create
    @comment = @task.comments.new(params.require(:comment).permit(:user_id, :task_id, :description))
    if current_user != nil
      @comment.user_id = current_user.id
    end
    if @comment.save
      flash[:notice] = "Comment was successfully created."
      redirect_to project_task_path(@project, @task )
    else
      redirect_to project_task_path(@project, @task)
    end
  end


end
