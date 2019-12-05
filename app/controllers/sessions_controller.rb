# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:session][:email])
    totp = ROTP::TOTP.new(user.secret_key)
    if user && user.authenticate(params[:session][:password]) && totp.verify(params[:session][:second_factor_authentication_code])
      log_in user
      redirect_to root_url, notice: "Logged in!"
    else
      flash.now[:alert] = "Email, password or validation code is invalid"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end
end
