class ClientAction < ApplicationRecord
  belongs_to :client
  accepts_nested_attributes_for :client
  enum wrap_session: [:no, :yes]
  enum wrap_action: [:open, :closed, :completed, :non_wrap, :no_change]
end
