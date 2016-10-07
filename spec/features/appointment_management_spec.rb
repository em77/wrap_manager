require "rails_helper"

feature "Manage appointments" do
  before(:each) do
    @user = create(:user)
    @client = build(:client)
    @appointment = build(:appointment)
    signin(@user.email, "password")
    create_client(@client.name)
  end

  scenario "user can create and delete an appointment from clients index" do
    visit clients_path
    within("div#client_#{@client.id}") do
      find_link("New appointment").click
    end

    fill_in "appointment_start_date", with: @appointment.start_date
    fill_in "appointment_start_time", with: @appointment.start_time
    fill_in "appointment_ending_date", with: @appointment.ending_date
    fill_in "appointment_ending_time", with: @appointment.ending_time
    find_button("submit_appointment").click
    expect(page).to have_content "Appointment created successfully"

    visit user_path(@user)
    expect(page).to have_content "#{Time.now.day} #{@client.name}"

    visit appointments_path
    within("div#appointment_#{@appointment.id}") do
      find_link("Delete appointment").click
    end
    expect(page).to have_content "Appointment deleted"
  end
end
