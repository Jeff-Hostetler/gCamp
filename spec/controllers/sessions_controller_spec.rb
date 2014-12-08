require "rails_helper"

describe SessionsController do
  describe "#new" do
    it "allows visitor to go to login page" do
      get :new

      expect(response).to be_success
    end
  end

  describe "#login" do
    it "allows user to sign in with valid data" do
       user = create_user

       post :login, session: {email: user.email, password: user.password}

       expect(session[:user_id]).to eq(user.id)
    end

    it "does not allow visitor to sign in with invalid info" do
      user = create_user

      post :login, session: {email: user.email, password: "Ihacker"}

      expect(session[:user_id]).to eq(nil)
    end
  end

  describe "#logout" do
    it "allows siged in user to logout" do
      user = create_user
      session[:user_id] = user.id

      delete :logout

      expect(session[:user_id]).to eq(nil)
      
    end
  end
end
