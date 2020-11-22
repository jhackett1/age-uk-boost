class ApplicationController < ActionController::Base

    helper_method :current_user
  
    private
  
    def current_user
      @current_user ||= authenticate_by_session
    end

    def authenticate_by_session
      current_session = AuthSession.find_by(id: session[:auth_session_id])
      if current_session
        current_session.user
      end
    end
  
    def authenticate_user!
      return if current_user
      redirect_to sign_in_path
    end
end