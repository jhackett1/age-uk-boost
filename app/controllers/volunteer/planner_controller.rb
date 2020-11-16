class Volunteer::PlannerController < Volunteer::BaseController
    def index
        @tasks = Order.where(assignee: current_user)
    end
end