require 'rails_helper'

feature "projects" do

  scenario 'attempt to create blank project' do
    user = User.create!(
      first_name: "First",
      last_name: "Last",
      email: "test@test.com",
      password: "password",
      password_confirmation: "password"
    )

    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "test@test.com"
    fill_in "Password", with: "password"
    within (".well") do
      click_on "Sign In"
    end
    click_on "Create Project"
    click_on "Create Project"

    expect(page).to have_content("Name can't be blank")
  end

  scenario 'attempt to update Project with invalid data' do
    project = Project.create!(
      name: "TEST"
    )
    user = User.create!(
      first_name: "First",
      last_name: "Last",
      email: "test@test.com",
      password: "password",
      password_confirmation: "password"
    )
    membership = Membership.create!(
      role: "owner",
      user_id: user.id,
      project_id: project.id
    )

    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "test@test.com"
    fill_in "Password", with: "password"
    within (".well") do
      click_on "Sign In"
    end
    visit project_path(project)
    click_on "Edit"
    fill_in "Name", with: ""
    click_on "Update Project"
    expect(page).to have_content("Name can't be blank")
  end

  scenario "create project" do
    user = User.create!(
      first_name: "First",
      last_name: "Last",
      email: "test@test.com",
      password: "password",
      password_confirmation: "password"
    )

    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "test@test.com"
    fill_in "Password", with: "password"
    within (".well") do
      click_on "Sign In"
    end
    click_on "Create Project"
    fill_in "Name", with: "This is a name"
    click_on "Create Project"

    expect(page).to have_content('This is a name')
    expect(page).to have_content('Project successfully created')

    within(".breadcrumb") do
      click_on "This is a name"
    end
    click_on "1 Member"
    within(".edit_membership") do
      expect(page).to have_content("owner")
    end
  end

  scenario "update project" do
    project = Project.create!(
      name: "TEST"
      )
    user = User.create!(
      first_name: "First",
      last_name: "Last",
      email: "test@test.com",
      password: "password",
      password_confirmation: "password"
      )
    membership = Membership.create!(
      role: "owner",
      user_id: user.id,
      project_id: project.id
      )

    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "test@test.com"
    fill_in "Password", with: "password"
    within (".well") do
      click_on "Sign In"
    end
    visit project_path(project)
    click_on "Edit"
    fill_in "Name", with: "Edited project"
    click_on "Update Project"
    expect(page).to have_content("Project was successfully updated")
  end

  scenario "delete project" do
    project = Project.create!(
      name: "TEST"
    )
    user = User.create!(
      first_name: "First",
      last_name: "Last",
      email: "test@test.com",
      password: "password",
      password_confirmation: "password"
    )
    membership = Membership.create!(
      role: "owner",
      user_id: user.id,
      project_id: project.id
    )

    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "test@test.com"
    fill_in "Password", with: "password"
    within (".well") do
      click_on "Sign In"
    end
    visit project_path(project)
    click_on "Delete"
    expect(page).to have_no_content("TEST")
  end

end
