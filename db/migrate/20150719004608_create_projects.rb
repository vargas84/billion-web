class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :blurb
      t.text :description

      t.timestamps null: false
    end
  end
end
