require "rails_helper"

describe MembershipsController do
  describe "index" do
    it "redirects visitors to login" do
      project = create_project
      user = create_user

      get :index, {project_id: project.id, user_id: user.id}

      expect(response).to redirect_to(login_path)
    end
  end
end
