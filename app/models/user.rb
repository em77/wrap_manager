class User < ApplicationRecord
  has_many :clients
  has_many :appointments, through: :clients

  enum role: [:peer_specialist, :supervisor]
  after_initialize :set_default_role, if: :new_record?
  authenticates_with_sorcery!
  validates_confirmation_of :password,
    message: "- Passwords must match", if: :password

  def set_default_role
    self.role ||= :peer_specialist
  end
end
