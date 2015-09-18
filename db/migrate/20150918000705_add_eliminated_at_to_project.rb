class AddEliminatedAtToProject < ActiveRecord::Migration
  def change
    add_column :projects, :eliminated_at, :datetime
  end
end
