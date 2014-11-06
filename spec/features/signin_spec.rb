require 'rails_helper'

feature "registration/ session" do

  # scenario "register a user valid info" do
  #
  #   visit root_path
  #   expect(page).to have_no_content("First Last")
  #   click_on "Sign Up"

    # fill_in "First name", with: "First"
    #
    # fill_in "Last name", with: "Last"
    # fill_in "Email", with: "test1@test.com"
    # fill_in "Password", with: "password"
    # fill_in "Password confirmation", with: "password"

    # click_button("Sign Up")
    # save_and_open_page


  #   expect(page).to have_content("First Last")
  #
  # end

  # scenario "try to register with invalid info" do
  #
  #   visit root_path
  #   click_on "Sign Up"
  #   click_button "Sign Up"
  #   expect(page).to have_content("Email can't be blank")

  # end

  scenario "user tries to sign in with invalid info" do

    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "blog@test.com"
    fill_in "Password", with: "test"
    click_button "Sign In"
    expect(page).to have_content "Incorrect email/password combination."

  end

  scenario "user signs in with valid info and sign out" do

    User.create!(
      first_name: "Test",
      last_name: "Test",
      email: "test@test.com",
      password: "test",
      password_confirmation: "test"
    )

    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "test@test.com"
    fill_in "Password", with: "test"
    click_button "Sign In"
    expect(page).to have_content("Test Test")
    # sign out test here
    click_on "Sign Out"
    expect(page).to have_no_content("Test Test")

  end
end
