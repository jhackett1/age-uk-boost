class PlannerController < ApplicationController
    before_action :authenticate_user!

    def index
        @upcoming = Task.claimed_by(current_user).incomplete.order(urgent: :desc)
        @recently_completed = Task.claimed_by(current_user).recently_completed
    end
end