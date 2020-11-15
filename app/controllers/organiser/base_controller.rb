class Organiser::BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :organisers_only

    private

    def organisers_only
        unless current_user.role.name === "organiser"
            redirect_to root_path
        end
    end
end