require 'rails_helper'

feature "users" do

  scenario "attempt to create user will no info add" do
    visit root_path
    click_on "Users"
    click_on "Create User"
    click_on "Create User"
    expect(page).to have_content('4 errors prohibited')
  end

  scenario "attempt to login user will email that is taken" do
    User.create!(
      first_name: "First",
      last_name: "Last",
      email: "test@test.com",
      password: "password",
      password_confirmation: "password"
    )

    visit root_path
    click_on "Users"
    click_on "Create User"
    fill_in "First name", with: "First"
    fill_in "Last name", with: "Last"
    fill_in "Email", with: "test@test.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_on "Create User"
    expect(page).to have_content("Email has already been taken")
  end

  scenario "create user" do
    visit root_path
    click_on "Users"
    expect(page).to have_no_content("First")
    click_on "Create User"
    fill_in "First name", with: "First"
    fill_in "Last name", with: "Last"
    fill_in "Email", with: "email@email.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_on "Create User"
    expect(page).to have_content('First Last')
    expect(page).to have_content('User was successfully created.')
    end

  scenario "update user" do

    User.create!(
      first_name: "First",
      last_name: "Last",
      email: "test@test.com",
      password: "password",
      password_confirmation: "password"
    )
    visit users_path
    expect(page).to have_content("First")
    click_on "First Last"
    expect(page).to have_content("First Last")
    click_on "Edit"
    fill_in "First name", with: "First1"
    fill_in "Last name", with: "Last1"
    # save_and_open_page
    click_on "Update User"
    expect(page).to have_content("First1 Last1")
  end

    scenario "delete user" do
    User.create!(
      first_name: "First",
      last_name: "Last",
      email: "test@test.com",
      password: "password",
      password_confirmation: "password"
    )
    visit users_path
    expect(page).to have_content("First Last")
    click_on "Edit"
    click_on "Delete User"
    expect(page).to have_no_content("First Last")
  end

end
