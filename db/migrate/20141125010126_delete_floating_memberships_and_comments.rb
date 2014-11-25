class DeleteFloatingMembershipsAndComments < ActiveRecord::Migration
  def change
    Membership.all.where(project_id = nil).delete_all
    Comment.all.where(task_id = nil).delete_all
  end
end
