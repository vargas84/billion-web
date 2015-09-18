class ProjectsController < ApplicationController
  def show
    @project = @competition.projects.friendly.find params[:id]
  end

  def index
    @projects = @competition.projects.order_by_points.order('eliminated_at NULLS FIRST, random()')
  end
end
