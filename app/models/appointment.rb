class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :client

  def self.destroy_all_future_appointments_for_client(client_id)
    Appointment.where("client_id = ? AND start > ?", client_id, Time.zone.now)
      .destroy_all
  end
end
