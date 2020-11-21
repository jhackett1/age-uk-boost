class ApplicationController < ActionController::Base
    # before_action :authenticate_user!
    # before_action :volunteers_only

    protected

    def volunteers_only
        unless current_user.role.name === "volunteer"
            redirect_to root_path
        end
    end

    def after_sign_in_path_for(resource)
        if current_user.role.name === "organiser"
            organiser_root_path 
        elsif current_user.role.name === "volunteer"
            volunteer_root_path 
        else
            root_path
        end
    end

end
