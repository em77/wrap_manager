module Features
  module SignUpHelpers
    def signup(email, password, password_confirmation)
      admin_user = create(:supervisor)
      signin(admin_user.email, "password")
      visit new_user_path
      fill_in "Email", with: email
      fill_in "Password", with: password
      fill_in "Password confirmation", with: password_confirmation
      click_on "Submit"
    end
  end
end
