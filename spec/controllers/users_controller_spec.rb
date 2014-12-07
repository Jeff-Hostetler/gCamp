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

  describe "create" do
    it "allows admin to create a user" do
      admin = create_admin
      session[:user_id] = admin.id

      post :create, user: {first_name: "Test",
                          last_name: "User",
                          email: "test@test.com",
                          password: "password",
                          password_confirmation: "password"}

    expect(User.count == 2)
    end
    it "allows user to create a user" do
      user = create_user
      session[:user_id] = user.id

      post :create, user: {first_name: "Test",
                          last_name: "User",
                          email: "test22@test.com",
                          password: "password",
                          password_confirmation: "password"}

        expect(User.count == 2)
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
  describe "#update" do
    it "allows user to update thier info" do
      user = create_user
      session[:user_id] = user.id

      patch :update, id: user.id, user: {first_name: "Test",
                                        last_name: "User",
                                        email: "test22@test.com",
                                        password: "password",
                                        password_confirmation: "password"}
      expect(user.reload.email).to eq("test22@test.com")
    end

    it "allows admin to update user info" do
      admin = create_admin
      user = create_user
      session[:user_id] = admin.id

      patch :update, id: user.id, user: {first_name: "Test",
                                        last_name: "User",
                                        email: "test22@test.com",
                                        password: "password",
                                        password_confirmation: "password"}
      expect(user.reload.email).to eq("test22@test.com")
    end
    it "allows user to update thier info" do
      user = create_user
      user2 = create_user2
      session[:user_id] = user2.id

      patch :update, id: user.id, user: {first_name: "Test",
                                        last_name: "User",
                                        email: "test22@test.com",
                                        password: "password",
                                        password_confirmation: "password"}
      expect(response.status).to eq(404)
    end
  end

  describe "delete" do
    it "allows user to delete themself" do
      user = create_user
      session[:user_id] = user.id

      delete :destroy, id: user.id

      expect(User.count).to eq(0)
    end
    it "allows admin to delete user" do
      user = create_user
      admin = create_admin
      session[:user_id] = admin.id

      delete :destroy, id: user.id

      expect(User.count).to eq(1)
    end
    it "does not allow user to delete another" do
      user = create_user
      user2 = create_user2
      session[:user_id] = user2.id

      delete :destroy, id: user.id

      expect(User.count).to eq(2)
    end
  end
end
