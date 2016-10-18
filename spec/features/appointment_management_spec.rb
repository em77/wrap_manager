require "rails_helper"

feature "Manage appointments" do
  before(:each) do
    @user = create(:supervisor)
    @client = build(:client)
    @appointment = build(:appointment)
    signin(@user.email, "password")
    create_client(@client.first_name, @client.last_name)
  end

  scenario "user can create and delete an appointment from clients index" do
    visit client_path(@client.id)
    find_link("New appointment").click

    fill_in "appointment_start", with: @appointment.start
    find_button("submit_appointment").click
    expect(page).to have_content "Appointment created successfully"

    visit my_calendar_path(@user)
    expect(page).to have_content "#{Time.zone.now.day} #{@client.first_name}"

    visit appointments_path
    within("div#appointment_#{@appointment.id}") do
      find_link("Delete appointment").click
    end
    expect(page).to have_content "Appointment deleted"
  end
end
