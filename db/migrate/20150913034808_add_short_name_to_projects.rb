class AddShortNameToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :short_name, :string
    add_index :projects, :short_name
    add_column :projects, :slug, :string
    add_index :projects, :slug, unique: true
  end
end
