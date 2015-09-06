class AddUrlsToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :video_url, :string
    add_column :projects, :card_image_url, :string
  end
end
