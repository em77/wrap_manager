require "rails_helper"

feature "Sign up", :sorcery do
  scenario "user can sign up with matching passwords and email" do
    signup("user@example.com", "password", "password")
    expect(page).to have_content "User created"
  end

  scenario "user can't sign up with non-matching passwords" do
    signup("user@example.com", "password", "wrongpassword")
    expect(page).to have_content "Passwords must match"
  end
end
