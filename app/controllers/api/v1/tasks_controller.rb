module Api
  module V1
    class TasksController < ApplicationController
      # GET /tasks
      # GET /tasks.json
      def index
        @tasks = Task.where(QueryParams.new(Task, params).build)

        render json: @tasks
      end

      # GET /tasks/1
      # GET /tasks/1.json
      def show
        @task = Task.find(params[:id])

        render json: @task
      end

      # POST /tasks
      # POST /tasks.json
      def create
        @task = Task.new(task_params)

        if @task.save
          render json: @task, status: :created
        else
          render_validation_errors @task.errors
        end
      end

      # PATCH/PUT /tasks/1
      # PATCH/PUT /tasks/1.json
      def update
        @task = Task.find(params[:id])

        authorize! :manage, @task

        if @task.update(task_params)
          head :no_content
        else
          render_validation_errors @task.errors
        end
      end

      # DELETE /tasks/1
      # DELETE /tasks/1.json
      def destroy
        @task = Task.find(params[:id])

        authorize! :manage, @task
        @task.destroy

        head :no_content
      end

      private
      def task_params
        params.require(:task).permit(:name, :completed, :workroom_id).
          merge(user: current_user)
      end
    end
  end
end