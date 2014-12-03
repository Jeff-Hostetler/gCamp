require "rails_helper"

describe TasksController do
  describe "index" do
    it "redirects visitors to login" do
      project = create_project

      get :index, {project_id: project.id}

      expect(response).to redirect_to(login_path)
    end
  end
end
