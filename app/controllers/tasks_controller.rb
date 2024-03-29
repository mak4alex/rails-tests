class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :up, :down]

  def show
  end

  def create
    @project = Project.find(params[:task][:project_id])
    unless current_user.can_view?(@project)
      redirect_to new_user_session_path
      return
    end
    @project.tasks.create(title: params[:task][:title],
      size: params[:task][:size],
      project_order: @project.next_task_order)
    redirect_to @project
  end

  def edit
  end

  def update
    completed = params[:task].delete(:completed)
    params[:task][:completed_at] = Time.current if completed
    if @task.update_attributes(task_params)
      TaskMailer.task_completed_email(@task).deliver_now if completed
      redirect_to @task, notice: 'Project was successfully updated.'
    else
      render :edit
    end
  end
  
  def up
    @task.move_up
    redirect_to @task.project
  end

  def down
    @task.move_down
    redirect_to @task.project
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:size, :completed_at, :project_id)
    end
end
