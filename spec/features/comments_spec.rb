require 'rails_helper'

feature 'comments' do

  scenario "signed in user can add comment to a task" do
    Project.create!(
      name: "TEST",
      id: 1
    )
    Task.create!(
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
    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "test@test.com"
    fill_in "Password", with: "password"
    within (".well") do
      click_on "Sign In"
    end

    visit root_path
    click_on "Projects"
    click_on "1"
    click_on "TEST TASK"
    fill_in "comment_description", with: "test description"
    click_on "Add Comment"
    expect(page).to have_content("Comment was successfully created")
  end

  scenario "signed in user attempts to create blank task" do
    Project.create!(
    name: "TEST",
    id: 1
    )
    Task.create!(
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
    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "test@test.com"
    fill_in "Password", with: "password"
    within (".well") do
      click_on "Sign In"
    end

    visit root_path
    click_on "Projects"
    click_on "1"
    click_on "TEST TASK"
    click_on "Add Comment"
    expect(page).to have_no_content("Comment was successfully created")
  end

end
