class Volunteer::BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :volunteers_only

    private

    def volunteers_only
        unless current_user.role.name === "volunteer"
            redirect_to root_path
        end
    end
end