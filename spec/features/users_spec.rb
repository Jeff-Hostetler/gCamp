require 'rails_helper'

feature "users" do
  scenario "new user signs up" do
    visit root_path
    click_on "Sign Up"
    fill_in "First name", with: "First"
    fill_in "Last name", with: "Last"
    fill_in "Email", with: "test@test.com"
    fill_in "Password", with: "pass"
    fill_in "Password confirmation", with: "pass"
    within(".well") do
      click_on "Sign Up"
    end

    expect(page).to have_content("New Project")
  end
  scenario "user signs in" do
    user = create_user

    visit root_path
    click_on "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    within (".well") do
      click_on "Sign In"
    end

    expect(page).to have_content("Create Project")
  end

  scenario "attempt to create user will no info add" do
    user = User.create!(
    first_name: "First",
    last_name: "Last",
    email: "test@test.com",
    password: "password",
    password_confirmation: "password",
    admin: true,
    )
    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "test@test.com"
    fill_in "Password", with: "password"
    within (".well") do
      click_on "Sign In"
    end

    visit users_path
    click_on "Create User"
    click_on "Create User"
    expect(page).to have_content('4 errors prohibited')
  end

  scenario "attempt to login user will email that is taken" do
    user = User.create!(
    first_name: "First",
    last_name: "Last",
    email: "test@test.com",
    password: "password",
    password_confirmation: "password",
    admin: true,
    )
    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "test@test.com"
    fill_in "Password", with: "password"
    within (".well") do
      click_on "Sign In"
    end

    visit users_path
    click_on "Create User"
    fill_in "First name", with: "First"
    fill_in "Last name", with: "Last"
    fill_in "Email", with: "test@test.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_on "Create User"
    expect(page).to have_content("Email has already been taken")
  end

  scenario "attempt to edit user with invalid info" do
    user = User.create!(
      first_name: "First",
      last_name: "Last",
      email: "test@test.com",
      password: "password",
      password_confirmation: "password",
      admin: true,
    )
    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "test@test.com"
    fill_in "Password", with: "password"
    within (".well") do
      click_on "Sign In"
    end

    visit user_path(user)
    click_on "Edit"
    fill_in "First name", with: ""
    fill_in "Last name", with: ""
    fill_in "Email", with: ""
    click_on "Update User"
    expect(page).to have_content("3 errors prohibited this from being saved")
  end

  scenario "admin can create user" do
    user = User.create!(
    first_name: "First",
    last_name: "Last",
    email: "test@test.com",
    password: "password",
    password_confirmation: "password",
    admin: true,
    )
    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "test@test.com"
    fill_in "Password", with: "password"
    within (".well") do
      click_on "Sign In"
    end

    visit users_path
    expect(page).to have_no_content("Firsty")
    click_on "Create User"
    fill_in "First name", with: "Firsty"
    fill_in "Last name", with: "Last"
    fill_in "Email", with: "email@email.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    fill_in "Pivotal Tracker Token", with: "password"
    click_on "Create User"
    expect(page).to have_content('First Last')
    expect(page).to have_content('User was successfully created.')
  end

  scenario "admin can update user" do
    user2 = User.create!(
      first_name: "Firsty",
      last_name: "Last",
      email: "test2@test.com",
      password: "password",
      password_confirmation: "password"
    )
    user = User.create!(
      first_name: "First",
      last_name: "Last",
      email: "test@test.com",
      password: "password",
      password_confirmation: "password",
      admin: true,
    )
    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "test@test.com"
    fill_in "Password", with: "password"
    within (".well") do
      click_on "Sign In"
    end

    visit users_path
    expect(page).to have_content("First")
    click_on "Firsty Last"
    expect(page).to have_content("First Last")
    click_on "Edit"
    fill_in "First name", with: "First1"
    fill_in "Last name", with: "Last1"
    fill_in "Pivotal Tracker Token", with: "1234567"
    click_on "Update User"
    expect(page).to have_content("First1 Last1")
    expect(page).to have_content("1234****************************")
  end

  scenario "delete user" do
    user2 = User.create!(
    first_name: "Firsty",
    last_name: "Last",
    email: "test2@test.com",
    password: "password",
    password_confirmation: "password"
    )
    user = User.create!(
    first_name: "First",
    last_name: "Last",
    email: "test@test.com",
    password: "password",
    password_confirmation: "password",
    admin: true,
    )
    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "test@test.com"
    fill_in "Password", with: "password"
    within (".well") do
      click_on "Sign In"
    end

    visit users_path
    click_on "Firsty Last"
    click_on "Edit"
    click_on "Delete User"
    expect(page).to have_no_content("Firsty Last")
  end

  scenario "admin can see other user emails" do
    user = create_user
    admin = create_admin

    visit root_path
    click_on "Sign In"
    fill_in "Email", with: admin.email
    fill_in "Password", with: admin.password
    within (".well") do
      click_on "Sign In"
    end
    click_on "Users"

    expect(page).to have_content(user.email)
    expect(page).to have_content(admin.email)
  end
  scenario "users can see other user emails if they share a project" do
    user = create_user
    user2 = create_user2
    project = create_project
    membership = create_owner(user, project)
    membership2 = create_member(user2, project)

    visit root_path
    click_on "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    within (".well") do
      click_on "Sign In"
    end
    click_on "Users"

    expect(page).to have_content(user.email)
    expect(page).to have_content(user2.email)
  end

  scenario "users cannot see other user emails if they do not share a project" do
    user = create_user
    user2 = create_user2
    project = create_project
    membership = create_owner(user, project)

    visit root_path
    click_on "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    within (".well") do
      click_on "Sign In"
    end
    click_on "Users"

    expect(page).to have_content(user.email)
    expect(page).to have_no_content(user2.email)
  end

end
