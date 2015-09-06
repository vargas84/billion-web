class AddInPersonToTempUsers < ActiveRecord::Migration
  def change
    add_column :temp_users, :in_person, :boolean, default: :false
  end
end
