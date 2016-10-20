class PagesController < ApplicationController
  before_action :require_login, except: [:home]
  after_action :verify_authorized, except: [:home]

  def home
  end

  def statistics
    authorize :page, :statistics?
  end
end
