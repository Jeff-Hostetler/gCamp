require 'rails_helper'

feature "tasks" do

  scenario "attempt to create blank task and blank date" do
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
    click_on "0 Tasks"
    click_on "Create Task"
    click_on "Create Task"

    expect(page).to have_content("Description can't be blank")
  end

  scenario "attempt to create task with date in past " do
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
    click_on "0 Tasks"
    click_on "Create Task"
    fill_in "Due", with: ("01/01/2014")
    click_on "Create Task"
    expect(page).to have_content("Due date must be in future")
  end

  scenario "attempt to edit task by added invalid data" do
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
    Task.create!(
    description: "TEST TASK",
    project_id: project.id,
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
    click_on "Edit"
    fill_in "Description", with: ""
    click_on "Update Task"

    expect(page).to have_content("Description can't be blank")
  end

  scenario "create task" do
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
    click_on "0 Tasks"
    click_on "Create Task"
    expect(page).to have_no_content("testtask")
    click_on "Create Task"
    fill_in "Description", with: "testtask"
    click_on "Create Task"
    expect(page).to have_content('testtask')
    expect(page).to have_content('Task was successfully created.')
  end

  scenario "update task" do
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
    Task.create!(
    description: "TEST TASK",
    project_id: project.id,
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
    click_on "Edit"
    fill_in "Description", with: "testtask"
    click_on "Update Task"
    expect(page).to have_content("testtask")
    expect(page).to have_content("Task was successfully updated.")
  end

  scenario "delete task" do
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
    Task.create!(
    description: "TEST TASK",
    project_id: project.id,
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
    expect(page).to have_content("TEST TASK")
    click_on "delete"
    expect(page).to have_no_content("TEST TASK")
  end

end
