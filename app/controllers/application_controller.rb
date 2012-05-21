class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user

  def verified_request?
    if request.content_type == "application/json"
      true
    else
      super()
    end
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
