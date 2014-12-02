require 'rails_helper'

feature 'comments' do

  scenario "visitor attempts to view comments" do
    Project.create!(
    name: "TEST",
    id: 1,
    )
    Task.create!(
    description: "TEST TASK",
    project_id: 1,
    id: 1,
    )
    visit "/projects/1/tasks/1"
    expect(page).to have_content("You must be logged in to access that action")

  end

  scenario "signed in user can add comment to a task" do
    project = Project.create!(
      name: "TEST",
      id: 1
    )
    task =Task.create!(
      description: "TEST TASK",
      project_id: 1
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
      project_id: 1
    )
    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "test@test.com"
    fill_in "Password", with: "password"
    within (".well") do
      click_on "Sign In"
    end
    visit project_path(project)
    click_on "1 Task"
    click_on "TEST TASK"
    fill_in "comment_description", with: "test description"
    click_on "Add Comment"
    expect(page).to have_content("Comment was successfully created")
  end

  scenario "signed in user attempts to create blank task" do
    project = Project.create!(
    name: "TEST",
    id: 1
    )
    task =Task.create!(
    description: "TEST TASK",
    project_id: 1
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
    project_id: 1
    )
    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "test@test.com"
    fill_in "Password", with: "password"
    within (".well") do
      click_on "Sign In"
    end
    visit project_path(project)
    click_on "1 Task"
    click_on "TEST TASK"
    click_on "Add Comment"
    expect(page).to have_no_content("Comment was successfully created")
  end

end
