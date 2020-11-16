class ApplicationController < ActionController::Base

    protected

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
