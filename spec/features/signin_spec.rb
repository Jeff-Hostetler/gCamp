require 'rails_helper'

feature "registration/ session" do
  scenario "user signs in" do
    visit root_path
    # save_and_open_page
    click_on "Sign In"

  end
end
