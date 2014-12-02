require 'rails_helper'

feature 'membership' do
  scenario "visitor attempts to view membership" do
    Project.create!(
    name: "TEST",
    id: 1
    )
    visit "/projects/1/memberships"
    expect(page).to have_content("You must be logged in to access that action")

  end

  scenario 'can add valid membership' do
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
    user2 = User.create!(
      first_name: "First",
      last_name: "Lasty",
      email: "test2@test.com",
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
    click_on "1 Member"
    select "First Lasty", from: "membership_user_id"
    click_on "Add New Member"
    expect(page).to have_content("First Lasty was added successfully")
    expect(page).to have_content("First Lasty")
    expect(page).to have_content("member")
  end

  scenario 'user attempts to add membership with no user assigned' do
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
    click_on "1 Members"
    click_on "Add New Member"
    expect(page).to have_content("User can't be blank")
  end

  scenario 'user attempts to add membership with a user that already has a membership' do
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
    click_on "1 Members"
    select "First Last", from: "membership_user_id"
    click_on "Add New Member"
    expect(page).to have_content("User has already been taken")
  end

  scenario 'membership can be updated' do
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
    user2 = User.create!(
    first_name: "First",
    last_name: "Lasty",
    email: "test2@test.com",
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
    click_on "1 Member"
    within(".edit_membership") do
      select "member", from: "membership_role"
    end
    click_on "Update"
    expect(page).to have_content("First Last was updated successfully")
    expect(page).to have_content("First Last")
    expect(page).to have_content("member")
  end

  scenario 'user can delete membership' do
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
    click_on "1 Member"
    within (".col-sm-6") do
      click_on ""
    end
    expect(page).to have_content "The page you were looking for doesn't exist"
  end


end
