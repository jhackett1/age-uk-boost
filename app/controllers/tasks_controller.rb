class TasksController < ApplicationController
    before_action :set_task, only: [:show, :update, :done]

    def index
        if params[:sort] === "recent"
            @clients = User.includes(:orders).order("orders.created_at DESC")
        else
            @clients = User.near([current_user.latitude, current_user.longitude], 200000)
        end
    end

    def show
    end

    def done
        if @task.completed_at
            @task.completed_at = nil
            flash[:notice] = "Marked as not done"
        else
            @task.completed_at = Time.now
            flash[:notice] = "Marked as done"
        end
        @task.save
        redirect_to volunteer_task_path(@task)
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
        @task = Order.find(params[:id] || params[:task_id])
    end
end