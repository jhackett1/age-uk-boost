class OnboardingsController < ApplicationController
    before_action :authenticate_user!
    before_action :check_not_onboarded
    before_action :set_me
    
    def show
    end

    def update
        @me.onboarded_at = Time.now
        if @me.update(user_params)
                        flash[:notice] = "You've released this task for others to claim."
            redirect_to root_path
        else
            render "show"
        end
    end

    private

    def set_me
        @me = current_user
    end
    
    def check_not_onboarded
        return unless current_user.onboarded_at
        redirect_to root_path
    end

    def user_params
        params.require(:user).permit(
            :address,
            :postcode
        )
    end
end