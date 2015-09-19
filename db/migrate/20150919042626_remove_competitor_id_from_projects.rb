class RemoveCompetitorIdFromProjects < ActiveRecord::Migration
  def change
    remove_reference :projects, :competitor, index: true
  end
end
