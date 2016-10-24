require "rails_helper"

feature "Create and delete client" do
  scenario "user can create and delete a client" do
    user = create(:supervisor)
    client = build(:client)
    supervisor = build(:supervisor)
    signin(user.email, "password")
    visit new_client_path
    fill_in "First name", with: client.first_name
    fill_in "Last name", with: client.last_name
    find_button("submit_client").click
    expect(page).to have_content "New client added to unassigned list"
    visit logout_path
    signin(supervisor.email, "password")
    visit client_path(client.id)
    find_link("Delete client").click
    expect(page).to have_content "Client deleted"
  end
end
