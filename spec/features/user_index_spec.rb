require "rails_helper"

feature "User index page", :sorcery do

  scenario "user's email is displayed" do
    user = create(:user, :supervisor)
    signin(user.email, "password")
    visit users_path
    expect(page).to have_content user.email
  end
end
