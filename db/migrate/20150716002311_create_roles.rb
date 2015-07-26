class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name

      t.timestamps null: false
    end

    change_table :users do |t|
      t.belongs_to :role, index: true
    end
  end
end
