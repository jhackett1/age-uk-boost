class TasksController < ApplicationController
    before_action :authenticate_user!
    before_action :set_task, only: [:show, :claim, :done]

    def index
        if params[:sort] === "recent"
            @tasks = Task.unclaimed.incomplete.order("created_at DESC")
        else
            @tasks = Task.unclaimed.incomplete.near([current_user.latitude, current_user.longitude], 200000)
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
        redirect_to task_path(@task)
    end

    def claim
        if @task.user === current_user
            @task.user = nil
            flash[:notice] = "Task released"
        else
            @task.user = current_user
            flash[:notice] = "Assigned to you"
        end
        @task.save
        render :show
    end

    private

    def set_task
        @task = Task.find(params[:id] || params[:task_id])
    end
end