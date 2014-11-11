require 'rails_helper'

feature "tasks" do

  scenario "attempt to create blank task and blank date" do
    visit tasks_path
    click_on "Create Task"
    click_on "Create Task"
    expect(page).to have_content("Description can't be blank")
  end

  scenario "attempt to create task with date in past " do
    visit tasks_path
    click_on "Create Task"
    click_on "Create Task"
    fill_in "Due", with: ("01/01/2014")
    click_on "Create Task"
    expect(page).to have_content("Due date must be in future")
  end

  scenario "create task" do
    visit tasks_path
    expect(page).to have_no_content("testtask")
    click_on "Create Task"
    fill_in "Description", with: "testtask"
    click_on "Create Task"
    expect(page).to have_content('testtask')
    expect(page).to have_content('Task was successfully created.')
  end

  scenario "update task" do

    Task.create!(
      description: "TEST"
    )
    visit tasks_path
    expect(page).to have_content("TEST")
    click_on "Edit"
    fill_in "Description", with: "test"
    click_on "Update Task"
    expect(page).to have_content("test")
    expect(page).to have_content("Task was successfully updated.")
  end

  scenario "delete task" do
    Task.create!(
      description: "TEST"
    )
    visit tasks_path
    expect(page).to have_content("TEST")
    click_on "Destroy"
    expect(page).to have_no_content("TEST")
  end

end
