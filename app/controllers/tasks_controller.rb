class TasksController < ApplicationController
  before_action :set_task

  def show
  end

  def edit
  end

  def update
    completed = params[:task].delete(:completed)
    params[:task][:completed_at] = Time.current if completed
    if @task.update_attributes(task_params)
      TaskMailer.task_completed_email(@task).deliver if completed
      redirect_to @task, notice: 'Project was successgully updated.'
    else
      render :edit
    end
  end
  


  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:size, :completed_at)
    end
end
