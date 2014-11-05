require 'rails_helper'

feature "projects" do

  scenario "create project" do
    visit root_path
    expect(page).to have_content("Projects")

    click_on "Projects"
    expect(page).to have_no_content("TEST")

    click_on "Create Project"

    fill_in "Name", with: "This is a name"
    click_on "Add Project"

    expect(page).to have_content('This is a name')
    expect(page).to have_content('Project successfully created')
  end

  scenario "update project" do

    Project.create!(
      name: "TEST"
    )
    visit projects_path
    expect(page).to have_content("TEST")
    click_on "TEST"
    expect(page).to have_content("TEST")
    click_on "Edit"
    fill_in "Name", with: "test"
    click_on "Update Project"
    expect(page).to have_content("test")
    expect(page).to have_content("Project was successfully updated.")
  end

  scenario "delete project" do
    Project.create!(
      name: "TEST"
    )
    visit projects_path
    expect(page).to have_content("TEST")
    click_on "TEST"
    click_on "Destroy"
    expect(page).to have_no_content("TEST")

  end

end
