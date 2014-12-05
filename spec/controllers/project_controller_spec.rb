require "rails_helper"

describe ProjectsController do
  describe "index" do

    it "redirects visitors to login" do
      get :index
      expect(response).to redirect_to(login_path)
    end

    it "allows users to see" do
      user = create_user
      session[:user_id] = user.id

      get :index

      expect(response).to be_success
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

  describe"edit" do
    it "allows owners to edit" do
      user = create_user
      project = create_project
      membership = create_owner(user, project)
      session[:user_id] = user.id

      get :edit, id: project.id
      expect(response).to be_success
    end

    it "does not allow members to edit" do
      user = create_user
      project = create_project
      membership = create_member(user, project)
      session[:user_id] = user.id

      get :edit, id: project.id
      expect(response.status).to eq(404)
    end

    it "allows admins to edit" do
      admin = create_admin
      project = create_project
      session[:user_id] = admin.id

      get :edit, id: project.id
      expect(response).to be_success
    end
  end

  describe "#destroy" do
    it "allows project owner to delete a project" do
      user = create_user
      project= create_project
      membership = create_owner(user, project)
      session[:user_id] = user.id

      delete :destroy, id: project.id

      expect(response).to redirect_to(projects_path)
    end

    it "does not allow project members to delete a project" do
      user = create_user
      project= create_project
      membership = create_member(user, project)
      session[:user_id] = user.id

      delete :destroy, id: project.id

      expect(response.status).to eq(404)
    end

    it "allows admin to delete any project" do
      admin = create_admin
      project= create_project
      session[:user_id] = admin.id

      delete :destroy, id: project.id

      expect(response).to redirect_to(projects_path)
    end
  end
end
