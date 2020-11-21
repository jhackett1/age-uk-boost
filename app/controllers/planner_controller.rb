class PlannerController < ApplicationController
    def index
        @tasks = Order.where(assignee: current_user)
    end
end