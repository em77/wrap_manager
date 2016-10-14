require "rails_helper"

feature "Create client action" do
  before(:each) do
    @user = create(:supervisor)
    @client = build(:client)
    @client_action = build(:client_action)
    signin(@user.email, "password")
    create_client(@client.name)
  end

  scenario "user can create and delete an action from client show page" do
    visit client_path(@client)
    find_link("New Action").click
    fill_in "client_action_notes", with: @client_action.notes
    find_button("save_client_action").click
    expect(page).to have_content "Action saved successfully"
    expect(page).to have_content @client_action.notes

    within("div#client_action_#{@client_action.id}") do
      find_link("Delete Action").click
    end
    expect(page).to have_content "Action deleted"
  end
end
