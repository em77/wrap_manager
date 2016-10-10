class Client < ApplicationRecord
  has_many :appointments
  has_many :client_actions
  belongs_to :user, optional: true
  enum wrap_status: [:open, :closed, :completed, :non_wrap]
  after_initialize :set_default_wrap_status, if: :new_record?

  def set_default_wrap_status
    self.wrap_status ||= :non_wrap
  end
end
