require "rails_helper"

describe ProjectsController do
  describe "index" do

    it "redirects visitors to login" do
      get :index
      expect(response).to redirect_to(login_path)
    end
  end

  describe "show" do
    it "shows users projects they are members of" do
      user = create_user
      project = create_project
      project2 = create_project2
      membership = create_owner(user, project)
      session[:user_id] = user.id

      get :show, id: project.id
      expect(response).to be_success
    end

    it "does not show users projects they are not members of" do
      user = create_user
      project = create_project
      session[:user_id] = user.id

      get :show, id: project.id
      expect(response.status).to eq(404)
    end

    it "shows admins all projects" do
      admin = create_admin
      project = create_project
      session[:user_id] = admin.id

      get :show, id: project.id
      expect(response).to be_success
    end

  end
end
