# frozen_string_literal: true

class ApplicationController < ActionController::Base

  helper_method :current_user
  helper_method :log_in


  private

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def log_in(user)
    session[:user_id] = user.id
  end
end
