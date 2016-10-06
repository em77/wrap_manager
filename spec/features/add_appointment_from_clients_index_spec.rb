require "rails_helper"

feature "Create and delete appointment from clients index" do
  scenario "user can create and delete an appointment from clients index" do
    user = create(:user)
    client = build(:client)
    appointment = build(:appointment)
    signin(user.email, "password")

    visit new_client_path
    fill_in "Name", with: client.name
    find_button("submit_client").click
    
    visit clients_path
    within("div#client_#{client.id}") do
      find_link("New appointment").click
    end
    fill_in "appointment_start_date", with: appointment.start_date
    fill_in "appointment_start_time", with: appointment.start_time
    find_button("submit_appointment").click
    expect(page).to have_content "Appointment created successfully"
    visit appointments_path
    within("div#appointment_#{appointment.id}") do
      find_link("Delete appointment").click
    end
    expect(page).to have_content "Appointment deleted"
  end
end
