namespace :data do
  desc "cleanup invalid memberships and comments"
  task cleanup: :environment do
    Membership.where.not(user_id: User.pluck(:id)).delete_all
    Membership.where.not(project_id: Project.pluck(:id)).delete_all
    Comment.where.not(task_id: Task.pluck(:id)).delete_all
  end
end
