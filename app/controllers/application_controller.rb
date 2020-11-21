class ApplicationController < ActionController::Base

    include Passwordless::ControllerHelpers

    helper_method :current_user
  
    private
  
    def current_user
      @current_user ||= authenticate_by_session(User)
    end
  
    def authenticate_user!
      return if current_user
      save_passwordless_redirect_location!(User)
      redirect_to auth.sign_in_path
    end
end