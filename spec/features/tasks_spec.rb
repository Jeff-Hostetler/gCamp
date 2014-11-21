require 'rails_helper'

feature "tasks" do

  scenario "attempt to create blank task and blank date" do
    Project.create!(
      name: "TEST"
    )

    visit root_path
    click_on "Projects"
    click_on "TEST"
    click_on "0 Tasks"
    click_on "Create Task"
    click_on "Create Task"

    expect(page).to have_content("Description can't be blank")
  end

  scenario "attempt to create task with date in past " do
    Project.create!(
      name: "TEST"
    )

    visit root_path
    click_on "Projects"
    click_on "TEST"
    click_on "0 Tasks"
    click_on "Create Task"
    click_on "Create Task"
    fill_in "Due", with: ("01/01/2014")
    click_on "Create Task"
    expect(page).to have_content("Due date must be in future")
  end

  scenario "attempt to edit task by added invalid data" do
    Project.create!(
      name: "TEST",
      id: 1
    )
    Task.create!(
      description: "TEST TASK",
      project_id: 1
      )

    visit root_path
    click_on "Projects"
    click_on "TEST"
    click_on "1 Task"
    click_on "Edit"
    fill_in "Description", with: ""
    click_on "Update Task"

    expect(page).to have_content("Description can't be blank")
  end

  scenario "create task" do
    Project.create!(
      name: "TEST"
    )

    visit root_path
    click_on "Projects"
    click_on "TEST"
    click_on "0 Tasks"
    expect(page).to have_no_content("testtask")
    click_on "Create Task"
    fill_in "Description", with: "testtask"
    click_on "Create Task"
    expect(page).to have_content('testtask')
    expect(page).to have_content('Task was successfully created.')
  end

  scenario "update task" do
    Project.create!(
      name: "TEST",
      id: 1
    )
    Task.create!(
      description: "TEST TASK",
      project_id: 1
      )

    visit root_path
    click_on "Projects"
    click_on "TEST"
    click_on "1 Task"
    click_on "Edit"
    fill_in "Description", with: "testtask"
    click_on "Update Task"
    expect(page).to have_content("testtask")
    expect(page).to have_content("Task was successfully updated.")
  end

  scenario "delete task" do
    Project.create!(
      name: "TEST",
      id: 1
    )
    Task.create!(
      description: "TEST TASK",
      project_id: 1
      )

    visit root_path
    click_on "Projects"
    click_on "TEST"
    click_on "1 Task"
    expect(page).to have_content("TEST TASK")
    click_on "delete"
    expect(page).to have_no_content("TEST TASK")
  end

end
