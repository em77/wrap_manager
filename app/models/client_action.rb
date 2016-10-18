class ClientAction < ApplicationRecord
  belongs_to :client
  accepts_nested_attributes_for :client
  enum wrap_session: [:no, :yes]
  enum wrap_action: [:open, :closed, :completed, :non_wrap, :no_change]
  after_initialize :set_default_wrap_session, if: :new_record?

  def set_default_wrap_session
    self.wrap_session ||= :no
  end
end
