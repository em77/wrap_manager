class Client < ApplicationRecord
  has_many :appointments, dependent: :destroy
  has_many :client_actions
  belongs_to :user, optional: true
  enum wrap_status: [:opened, :closed, :completed, :non_wrap]
  after_initialize :set_default_wrap_status, if: :new_record?

  def set_default_wrap_status
    self.wrap_status ||= :non_wrap
  end
end
