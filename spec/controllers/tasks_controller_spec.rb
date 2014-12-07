require "rails_helper"

describe TasksController do
  describe "index" do

    it "redirects visitors to login" do
      project = create_project

      get :index, {project_id: project.id}

      expect(response).to redirect_to(login_path)
    end

    it "displays tasks to users who are members" do
      user = create_user
      project = create_project
      task = create_task(project)
      membership = create_member(user, project)
      session[:user_id] = user.id

      get :index, {project_id: project.id}

      expect(response).to be_success
    end

    it "displays tasks to users who are owners" do
      user = create_user
      project = create_project
      task = create_task(project)
      membership = create_owner(user, project)
      session[:user_id] = user.id

      get :index, {project_id: project.id}

      expect(response).to be_success
    end
    it "displays tasks to users who are admins" do
      admin = create_admin
      project = create_project
      task = create_task(project)
      session[:user_id] = admin.id

      get :index, {project_id: project.id}

      expect(response).to be_success
    end

    it "does not display tasks to non members/user/admin" do
      user = create_user
      project = create_project
      task = create_task(project)
      session[:user_id] = user.id

      get :index, project_id: project.id

      expect(response.status).to eq(404)
    end
  end

  describe "#create" do
    it "allows member to create tasks" do
      user = create_user
      project = create_project
      membership = create_owner(user, project)
      session[:user_id] = user.id
      post :create, project_id: project.id, task: { project_id: project, description: Faker::Lorem.sentence }

      expect(response.status).to eq(302)
    end
    it "allows admin to create tasks" do
      admin = create_admin
      project = create_project
      session[:user_id] = admin.id
      post :create, project_id: project.id, task: { project_id: project, description: Faker::Lorem.sentence }

      expect(response.status).to eq(302)
    end
    it "does not allow non-member to create tasks" do
      user = create_user
      project = create_project
      session[:user_id] = user.id
      post :create, project_id: project.id, task: { project_id: project, description: Faker::Lorem.sentence }

      expect(response.status).to eq(404)
    end
  end

  describe "#show" do
    it "shows task to members" do
      user = create_user
      project = create_project
      task = create_task(project)
      membership = create_member(user, project)
      session[:user_id] = user.id

      get :show, project_id: project.id, id: task.id

      expect(response).to be_success
    end

    it "shows task to owners" do
      user = create_user
      project = create_project
      task = create_task(project)
      membership = create_owner(user, project)
      session[:user_id] = user.id

      get :show, project_id: project.id, id: task.id

      expect(response).to be_success
    end

    it "shows all tasks to admin" do
      admin = create_admin
      project = create_project
      task = create_task(project)
      session[:user_id] = admin.id

      get :show, project_id: project.id, id: task.id

      expect(response).to be_success
    end
  end

  describe "#edit" do
    it "allows member to edit task" do
      user = create_user
      project = create_project
      task = create_task(project)
      membership = create_member(user, project)
      session[:user_id] = user.id

      get :edit, project_id: project.id, id: task.id

      expect(response).to be_success
    end

    it "does not allow a non-member to edit a task" do
      user = create_user
      project = create_project
      task = create_task(project)
      session[:user_id] = user.id

      get :edit, project_id: project.id, id: task.id

      expect(response.status).to eq(404)
    end

    it "allows admin to edit any task" do
      admin = create_admin
      project = create_project
      task = create_task(project)
      session[:user_id] = admin.id

      get :edit, project_id: project.id, id: task.id

      expect(response).to be_success
    end
  end
  describe "#update" do
    it "allows member to update tasks" do
      user = create_user
      project = create_project
      task = create_task(project)
      membership = create_member(user, project)
      session[:user_id] = user.id
      patch :update, project_id: project.id, id: task.id, task: { project_id: project, description: Faker::Lorem.sentence }

      expect(response.status).to eq(302)
    end
    it "allows admin to update tasks" do
      admin = create_admin
      project = create_project
      task = create_task(project)
      session[:user_id] = admin.id
      patch :update, project_id: project.id, id: task.id, task: { project_id: project, description: Faker::Lorem.sentence }

      expect(response.status).to eq(302)
    end
    it "does not allow non-member to update tasks" do
      user = create_user
      project = create_project
      task = create_task(project)
      session[:user_id] = user.id
      patch :update, project_id: project.id, id: task.id, task: { project_id: project, description: Faker::Lorem.sentence }

      expect(response.status).to eq(404)
    end
  end

  describe "#delete" do

    it "allows member to delete tasks" do
      user = create_user
      project = create_project
      task = create_task(project)
      membership = create_owner(user, project)
      session[:user_id] = user.id
      delete :destroy, project_id: project.id, id: task.id, task: { project_id: project, description: Faker::Lorem.sentence }

      expect(response.status).to eq(302)
    end
    it "allows admin to delete tasks" do
      admin = create_admin
      project = create_project
      task = create_task(project)
      session[:user_id] = admin.id
      delete :destroy, project_id: project.id, id: task.id, task: { project_id: project, description: Faker::Lorem.sentence }

      expect(response.status).to eq(302)
    end
    it "does not allow non-member to delete tasks" do
      user = create_user
      project = create_project
      task = create_task(project)
      session[:user_id] = user.id
      delete :destroy, project_id: project.id, id: task.id, task: { project_id: project, description: Faker::Lorem.sentence }

      expect(response.status).to eq(404)
    end
  end
end
