class ProfilesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_me
    
    def show
    end

    def update
        if @me.update(user_params)
            flash[:notice] = "Your profile has been updated."
            redirect_to profile_path
        else
            render "show"
        end
    end

    private

    def set_me
        @me = current_user
    end

    def user_params
        params.require(:user).permit(
            :address,
            :postcode,
            :notify_about_new_tasks,
            :notify_about_due_tasks
        )
    end
end