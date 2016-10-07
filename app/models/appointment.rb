class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :client

  date_time_attributes_for :start
  date_time_attributes_for :ending
end
