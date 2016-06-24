class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update]

  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
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
  end

  def update
    if @project.update_attributes(params[:project])
      redirect_to @project, alert: 'Project was successfully updated.'
    else
      render :edit
    end
  end

  private

    def set_project
      @project = Project.find(params[:id])
    end

end
