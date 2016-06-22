class ProjectsController < ApplicationController

  def index
    @project = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @action = CreatesProject.new(
      name: params[:project][:name],
      task_string: params[:project][:tasks])
    success = @action.create
    if success
      redirect_to projects_path  
    else
      @project = @action.project
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      redirect_to @project, alert: 'Project was successfully updated.'
    else
      render :edit
    end
  end

end
