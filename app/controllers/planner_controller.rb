class PlannerController < ApplicationController
    before_action :authenticate_user!

    def index
        upcoming = Task.claimed_by(current_user).incomplete.order(urgent: :desc)

        @next = upcoming.first
        @upcoming = upcoming.drop(1)
        @recently_completed = Task.claimed_by(current_user).recently_completed
    end
end