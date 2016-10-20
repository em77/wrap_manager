class MonthlyStat < ApplicationRecord

  attr_accessor :time_range

  def set_monthly_values(year, month)
    @time_range = get_time_range(year, month)
    self.year = year
    self.month = month
    self.total_wrap_sessions = get_total_wrap_sessions.count
    self.unique_clients_attended_wrap_sessions =
      get_unique_clients_attended_wrap_sessions.count
    self.total_wraps_opened = get_total_wraps_opened.count
    self.total_wraps_completed = get_total_wraps_completed.count
    self.total_non_wrap = get_total_non_wrap.count
    self.unique_clients_attended_non_wrap =
      get_unique_clients_attended_non_wrap.count
  end

  def get_time_range(year, month)
    dt = DateTime.new(year, month)
    ClientAction.where("created_at >= ? AND created_at <= ?",
      dt.beginning_of_month, dt.end_of_month).to_a
  end

  def get_total_wrap_sessions
    time_range.select {|record| record.wrap_session == "yes"}
  end

  def get_unique_clients_attended_wrap_sessions
    get_total_wrap_sessions.uniq {|record| record.client_id}
  end

  def get_total_wraps_opened
    time_range.select {|record| record.wrap_action == "open"}
  end

  def get_total_wraps_completed
    time_range.select {|record| record.wrap_action == "completed"}
  end

  def get_total_non_wrap
    time_range.select {|record| record.wrap_session == "no"}
  end

  def get_unique_clients_attended_non_wrap
    get_total_non_wrap.uniq {|record| record.client_id}
  end
end
