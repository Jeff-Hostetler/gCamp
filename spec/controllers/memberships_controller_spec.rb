require "rails_helper"

describe MembershipsController do
  describe "index" do
    it "redirects visitors to login" do
      project = create_project
      user = create_user

      get :index, {project_id: project.id, user_id: user.id}

      expect(response).to redirect_to(login_path)
    end

    it "allows members of projects to view memberships" do
      project = create_project
      user = create_user
      membership = create_member(user, project)
      session[:user_id] = user.id

      get :index, {project_id: project.id}

      expect(response).to be_success
    end

    it "allows admins to view memberships" do
      project = create_project
      admin = create_admin
      session[:user_id] = admin.id

      get :index, {project_id: project.id}

      expect(response).to be_success
    end

    it "does not allow non-members of projects to view memberships" do
      project = create_project
      user = create_user

      session[:user_id] = user.id

      get :index, {project_id: project.id}

      expect(response.status).to eq(404)
    end


  end
end
