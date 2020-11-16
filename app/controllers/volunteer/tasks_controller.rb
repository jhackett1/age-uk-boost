class Volunteer::TasksController < Volunteer::BaseController
    before_action :set_task, only: [:show, :update]

    def index
        if params[:recent] === "true"
            @clients = User.includes(:orders).order("orders.created_at DESC")
        else
            @clients = User.near([current_user.latitude, current_user.longitude], 200000)
        end
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