require "rails_helper"

feature "Create client action" do
  before(:each) do
    @user = create(:user)
    @client = build(:client)
    @appointment = build(:appointment)
    signin(@user.email, "password")
    create_client(@client.name)
  end

  scenario "user can create and delete an action from client show page" do
    #
  end
end
