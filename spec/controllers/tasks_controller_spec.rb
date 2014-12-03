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

      get :index, {project_id: project.id}

      expect(response.status).to eq(404)
    end


  end
end
