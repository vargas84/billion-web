class ProjectsController < ApplicationController
  def show
    @project = Project.friendly.find params[:id]
  end

  def index
    @projects = Project.all
  end
end
