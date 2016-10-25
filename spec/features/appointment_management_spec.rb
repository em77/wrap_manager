require "rails_helper"

feature "Manage appointments" do
  before(:each) do
    @user = create(:user)
    @client = build(:client)
    @appointment = build(:appointment)
    signin(@user.email, "password")
    create_client(@client.first_name, @client.last_name)
    saved_client = Client.last
    saved_client.user_id = @user.id
    saved_client.save
  end

  scenario "user can create and delete an appointment from clients index" do
    visit client_path(@client.id)
    find_link("New appointment").click

    fill_in "appointment_start", with: @appointment.start
    find_button("submit_appointment").click
    expect(page).to have_content "Appointment created successfully"

    saved_appointment = Appointment.find(@appointment.id)
    visit my_calendar_path(@user)
    expect(page).to have_content "#{saved_appointment.start.day}" +
      " #{@client.first_name} #{@client.last_name}"

    visit appointments_path
    within("div#appointment_#{@appointment.id}") do
      find_link("Delete appointment").click
    end
    expect(page).to have_content "Appointment deleted"
  end
end
