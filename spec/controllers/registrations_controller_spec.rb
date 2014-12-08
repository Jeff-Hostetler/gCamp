require "rails_helper"

describe RegistrationsController do
  describe "#new" do
    it "allows vistor to access signup page" do
      get :new
      expect(response).to be_success
    end
  end

  describe "#create" do
    it "allows user creation with valid data" do
      expect(User.count).to eq(0)
      post :create, user: {email: "test@test.com", first_name: "Test", last_name: "Last",
                                  password: "pass", password_confirmation: "pass"}
      expect(User.count).to eq(1)
    end
    it "does not allow user creation with invalid data" do
      expect(User.count).to eq(0)
      post :create, user: {email: "test@test.com", first_name: "Test", last_name: "Last",
        password: "pass", password_confirmation: "passs"}
        expect(User.count).to eq(0)
      end
  end
end
