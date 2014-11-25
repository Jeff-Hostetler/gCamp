require 'rails_helper'

feature 'membership' do

  scenario 'can add valid membership' do
    Project.create!(
      name: "TEST"
      )
    User.create!(
      first_name: "First",
      last_name: "Last",
      email: "test@test.com",
      password: "password",
      password_confirmation: "password"
      )

    visit root_path
    click_on "Projects"
    click_on "TEST"
    click_on "0 Members"
    select "First Last", from: "membership_user_id"
    click_on "Add New Member"
    expect(page).to have_content("First Last was added successfully")
  end

  scenario 'user attempts to add membership with no user assigned' do
    Project.create!(
      name: "TEST"
    )
    User.create!(
      first_name: "First",
      last_name: "Last",
      email: "test@test.com",
      password: "password",
      password_confirmation: "password"
    )

    visit root_path
    click_on "Projects"
    click_on "TEST"
    click_on "0 Members"
    click_on "Add New Member"
    expect(page).to have_content("User can't be blank")
  end

  scenario 'user attempts to add membership with a user that already has a membership' do
    Project.create!(
      name: "TEST"
    )
    User.create!(
      first_name: "First",
      last_name: "Last",
      email: "test@test.com",
      password: "password",
      password_confirmation: "password"
    )

    visit root_path
    click_on "Projects"
    click_on "TEST"
    click_on "0 Members"
    select "First Last", from: "membership_user_id"
    click_on "Add New Member"
    expect(page).to have_content("First Last was added successfully")
    select "First Last", from: "membership_user_id"
    click_on "Add New Member"
    expect(page).to have_content("User has already been taken")
  end

  scenario 'membership can be updated' do
    Project.create!(
      name: "TEST"
    )
    User.create!(
      first_name: "First",
      last_name: "Last",
      email: "test@test.com",
      password: "password",
      password_confirmation: "password"
    )

    visit root_path
    click_on "Projects"
    click_on "TEST"
    click_on "0 Members"
    select "First Last", from: "membership_user_id"
    click_on "Add New Member"
    expect(page).to have_content("First Last was added successfully")
    within(".edit_membership") do
      select "admin", from: "membership_role"
    end
    click_on "Update"
    expect(page).to have_content("First Last was updated successfully")
  end

  scenario 'user can delete membership' do
    Project.create!(
      name: "TEST"
    )
    User.create!(
      first_name: "First",
      last_name: "Last",
      email: "test@test.com",
      password: "password",
      password_confirmation: "password"
    )

    visit root_path
    click_on "Projects"
    click_on "TEST"
    click_on "0 Members"
    select "First Last", from: "membership_user_id"
    click_on "Add New Member"
    expect(page).to have_content("First Last was added successfully")
    within (".col-sm-6") do
      click_on ""
    end
    expect(page).to have_content "First Last was deleted successfully"
  end


end
