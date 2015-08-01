class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.references :project, null: false
      t.references :user, null: false
    end
  end
end
