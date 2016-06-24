class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update]

  def index
    @projects = ProjectPresenter.from_project_list(current_user.visible_projects)
  end

  def show
    unless current_user.can_view?(@project)
      redirect_to new_user_session_path
      return
    end
  end

  def new
    @project = Project.new
  end

  def create
    @action = CreatesProject.new(
      name: params[:project][:name],
      task_string: params[:project][:tasks]
      users: [current_user])
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
    if @project.update_attributes(params[:project].permit(:name))
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
