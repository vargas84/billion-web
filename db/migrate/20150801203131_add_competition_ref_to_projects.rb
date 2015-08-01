class AddCompetitionRefToProjects < ActiveRecord::Migration
  def change
    add_reference :projects, :competition, index: true, null: false
  end
end
