class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :client

  date_time_attributes_for :start
  date_time_attributes_for :ending

  def self.destroy_all_future_appointments_for_client(client_id)
    Appointment.where("client_id = ? AND start > ?", client_id, Time.now)
      .destroy_all
  end
end
