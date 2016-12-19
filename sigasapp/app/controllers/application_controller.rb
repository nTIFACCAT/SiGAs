class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #before_filter :access_verify_session
  
  protected
    def access_verify_session
      unless session[:current_user]
      redirect_to login_path
      end
    end
end
