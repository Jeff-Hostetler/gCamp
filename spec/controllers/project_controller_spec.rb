require "rails_helper"

describe ProjectsController do
  describe "index" do
    it "redirects visitors to login" do
      get :index
      expect(response).to redirect_to(login_path)
    end
  end
end
