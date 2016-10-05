require "rails_helper"

feature "Create and delete client" do
  scenario "user can create and delete a client" do
    user = create(:user)
    client = build(:client)
    signin(user.email, "password")
    visit new_client_path
    fill_in "Name", with: client.name
    find_button("submit_client").click
    expect(page).to have_content "Client created successfully"
    within("div#client_#{client.id}") do
      find_link("Delete client").click
    end
    expect(page).to have_content "Client deleted"
  end
end
