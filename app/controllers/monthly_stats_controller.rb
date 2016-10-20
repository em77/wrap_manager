class MonthlyStatsController < ApplicationController
  before_action :require_login
  after_action :verify_authorized

  attr_accessor :monthly_stats
  helper_method :monthly_stats

  def index
    @monthly_stats = MonthlyStat.all
    authorize @monthly_stats
  end
end
