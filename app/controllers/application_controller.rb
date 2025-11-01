class ApplicationController < ActionController::Base
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  protect_from_forgery with: :exception

  def set_referer
    session[:return_to] ||= request.referer
  end

  private

    def user_not_authorized
      flash[:error] = "Access denied"
      redirect_to(session[:return_to] || root_path)
    end
end
