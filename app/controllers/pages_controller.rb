class PagesController < ApplicationController
  before_action :require_login, except: [:home]

  def home
  end
end
