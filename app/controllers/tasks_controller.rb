class TasksController < ApplicationController
    before_action :authenticate_user!
    before_action :set_task, only: [:show, :claim, :done]

    def index
        if params[:sort] === "recent" || !current_user.has_coordinates?
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
        else
            @task.completed_at = Time.now
        end
        @task.save
        redirect_to task_path(@task)
    end

    def claim
        if @task.user === current_user
            @task.user = nil
            flash[:notice] = "You've released this task for others to claim."
        else
            @task.user = current_user
            flash[:notice] = "You've claimed this task. Thank you!"
        end
        @task.save
        redirect_to task_path(@task)
    end

    private

    def set_task
        # TODO: refactor this so it can only return tasks the user is allowed to see
        @task = Task.find(params[:id] || params[:task_id])
    end
end