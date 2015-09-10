class AddProjectImageUrlToProject < ActiveRecord::Migration
  def change
    add_column :projects, :project_image_url, :string
  end
end
