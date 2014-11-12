require 'rails_helper'

describe User do

  it "validates uniqueness of User email" do
    User.create!(
    first_name: "test",
    last_name: "test",
    email: "TEST@Test.Com",
    password: "password",
    password_confirmation: "password"
    )

    user = User.new(email: "test@test.com")
    user.valid?
    expect(user.errors[:email].present?).to eq(true)
  end

end
