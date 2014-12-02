require "rails_helper"

describe PagesController do
  describe "#index" do

    it "allows visitors to visit the index page" do
      get :index
      expect(response).to be_success
    end
    it "allows visitors to visit the faq page" do
      get :faq
      expect(response).to be_success
    end
    it "allows visitors to visit the about page" do
      get :about
      expect(response).to be_success
    end
    it "allows visitors to visit the terms page" do
      get :terms
      expect(response).to be_success
    end

  end
end
