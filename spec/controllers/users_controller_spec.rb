require "rails_helper"

describe UsersController do
  describe "index" do
    it "redirects visitors to login" do
      get :index

      expect(response).to redirect_to(login_path)
    end

    it "allows user to see user index" do
      user = create_user
      session[:user_id] = user.id

      get :index

      expect(response).to be_success
    end

  end

  describe "edit" do
    it "allows user to edit thier own page" do
      user = create_user
      session[:user_id] = user.id

      get :edit, id: user.id

      expect(response).to be_success
    end

    it "does not allow user to edit other users page" do
      user = create_user
      user2 = create_user2
      session[:user_id] = user.id

      get :edit, id: user2.id

      expect(response.status).to eq(404)
    end

    it "allows admin to edit user info" do
      user = create_user
      admin = create_admin
      session[:user_id] = admin.id

      get :edit, id: user.id

      expect(response).to be_success
    end

  end
end
