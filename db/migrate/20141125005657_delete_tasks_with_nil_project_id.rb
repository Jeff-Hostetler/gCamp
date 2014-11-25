class DeleteTasksWithNilProjectId < ActiveRecord::Migration
  def change
    Task.all.where(project_id = nil).delete_all
  end
end
