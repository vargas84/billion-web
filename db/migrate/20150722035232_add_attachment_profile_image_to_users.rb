class AddAttachmentProfileImageToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.attachment :profile_image
      t.string :first_name
      t.string :last_name
    end
  end

  def self.down
    remove_attachment :users, :profile_image
  end
end
