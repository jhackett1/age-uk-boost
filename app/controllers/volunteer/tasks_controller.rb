class Volunteer::TasksController < Volunteer::BaseController
    before_action :set_task, only: [:show, :update]

    def index
        @tasks = Order.available
    end

    def show
    end

    def update
        if @task.assignee === current_user
            @task.assignee = nil
            flash[:notice] = "Task released"
        else
            @task.assignee = current_user
            flash[:notice] = "Assigned to you"
        end
        @task.save
        render :show
    end

    private

    def set_task
        @task = Order.find(params[:id])
    end
end