class AddCompetitorToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :competitor_id, :integer
    add_index :projects, :competitor_id
    add_foreign_key :projects, :projects, column: :competitor_id
  end
end
