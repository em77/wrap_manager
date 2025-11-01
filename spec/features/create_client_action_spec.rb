require "rails_helper"

feature "Create client action" do
  before(:each) do
    @user = create(:user)
    @client = build(:client)
    @client_action = build(:client_action)
    signin(@user.email, "password")
    create_client(@client.first_name, @client.last_name)
    @saved_client = Client.last
    @saved_client.user_id = @user.id
    @saved_client.save
  end

  scenario "user can create and delete an action from client show page" do
    visit client_path(@saved_client)
    find_link("New Action").click
    fill_in "client_action_notes", with: @client_action.notes
    find_button("save_client_action").click
    expect(page).to have_content "Action saved successfully"
    expect(page).to have_content @client_action.notes

    saved_action = ClientAction.last
    within("div#client_action_#{saved_action.id}") do
      find_link("Delete Action").click
    end
    expect(page).to have_content "Action deleted"
  end

  scenario "wrap_action should reflect changes to wrap_status" do
    visit client_path(@saved_client)
    find_link("New Action").click
    choose("client_action_client_wrap_status_opened")
    choose("client_action_wrap_session_yes")
    find_button("save_client_action").click
    expect(page).to have_content "Action saved successfully"
    first_action = ClientAction.last
    expect(first_action.wrap_action).to eq "opened"
    expect(@saved_client.reload.wrap_status).to eq "opened"

    within("div#client_action_#{first_action.id}") do
      find_link("client_action_#{first_action.id}_link").click
    end
    expect(page).to have_content "OPEN"

    visit client_path(@saved_client)
    find_link("New Action").click
    choose("client_action_wrap_session_yes")
    find_button("save_client_action").click
    expect(page).to have_content "Action saved successfully"

    within("div#client_action_2") do
      find_link("client_action_2_link").click
    end
    expect(ClientAction.find(2).wrap_action).to eq "no_change"
    expect(Client.find(1).wrap_status).to eq "opened"
  end
end
