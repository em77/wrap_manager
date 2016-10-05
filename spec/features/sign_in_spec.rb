require "rails_helper"

feature "Sign in", :sorcery do
  scenario "user can't sign in without being registered" do
    signin("user@example.com", "password")
    expect(page).to have_content "Invalid email or password"
  end

  scenario "user can sign in with valid login/password" do
    user = create(:user)
    signin(user.email, "password")
    expect(page).to have_content "Signed in successfully"
  end

  scenario "user can't sign in with invalid email" do
    user = create(:user)
    signin("invalid@example.com", user.password)
    expect(page).to have_content "Invalid email or password"
  end

  scenario "user can't sign in with invalid password" do
    user = create(:user)
    signin(user.email, "wrongpassword")
    expect(page).to have_content "Invalid email or password"
  end
end