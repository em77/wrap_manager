require "rails_helper"

feature "Create client action" do
  before(:each) do
    @user = create(:supervisor)
    @client = build(:client)
    @client_action = build(:client_action)
    signin(@user.email, "password")
    create_client(@client.first_name, @client.last_name)
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

  scenario "wrap_action should reflect changes to wrap_status" do
    visit client_path(@client)
    find_link("New Action").click
    choose("client_action_client_wrap_status_open")
    find_button("save_client_action").click
    expect(page).to have_content "Action saved successfully"
    expect(ClientAction.find(1).wrap_action).to eq "open"
    expect(Client.find(1).wrap_status).to eq "open"

    within("div#client_action_#{@client_action.id}") do
      find_link("client_action_#{@client_action.id}_link").click
    end
    expect(page).to have_content "OPEN"

    visit client_path(@client)
    find_link("New Action").click
    find_button("save_client_action").click
    expect(page).to have_content "Action saved successfully"

    within("div#client_action_2") do
      find_link("client_action_2_link").click
    end
    expect(ClientAction.find(2).wrap_action).to eq "no_change"
    expect(Client.find(1).wrap_status).to eq "open"
  end
end
