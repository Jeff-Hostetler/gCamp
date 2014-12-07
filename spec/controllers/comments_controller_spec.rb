require "rails_helper"

describe CommentsController do

  describe "#create" do

    it "allows member to create comments" do
      user = create_user
      project = create_project
      task = create_task(project)
      membership = create_owner(user, project)
      session[:user_id] = user.id

      post :create, project_id: project.id, task_id: task.id, comment: { task_id: task, description: Faker::Lorem.sentence }

      expect(response.status).to eq(302)
    end
    it "allows admin to create comments" do
      admin = create_admin
      project = create_project
      task = create_task(project)
      session[:user_id] = admin.id

      post :create, project_id: project.id, task_id: task.id, comment: { task_id: task, description: Faker::Lorem.sentence }

      expect(response.status).to eq(302)
    end
    it "does not allow non-member to create comments" do
      user = create_user
      project = create_project
      task = create_task(project)
      session[:user_id] = user.id

      post :create, project_id: project.id, task_id: task.id, comment: { task_id: task, description: Faker::Lorem.sentence }

      expect(response.status).to eq(302)
    end
  end

end
