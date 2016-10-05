class PasswordResetsController < ApplicationController
  # skip_before_filter :require_login

  attr_accessor :token, :user
  helper_method :token, :user

  def new
  end

  def create
    @user = User.find_by_email(params[:email])
    @user.deliver_reset_password_instructions! if @user
    redirect_to(login_path, notice: "Password reset instructions have been" +
      " sent to the e-mail you provided. Please check your spam folder if" +
      " you don't see the e-mail.")
  end

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])
    if @user.blank?
      not_authenticated
      return
    end
  end

  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])
    if @user.blank?
      not_authenticated
      return
    end
    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.change_password!(params[:user][:password])
      redirect_to(login_path, notice: "Password successfully updated")
    else
      render action: "edit"
    end
  end
end
