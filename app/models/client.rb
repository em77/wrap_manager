class Client < ApplicationRecord
  has_many :appointments
  has_many :client_actions
  belongs_to :user, optional: true
end
