class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.references :round, index: true
      t.references :project_1, index: true
      t.references :project_2, index: true
      t.datetime :deleted_at

      t.timestamps
    end
    add_foreign_key :matches, :rounds
    add_foreign_key :matches, :projects, column: :project_1_id
    add_foreign_key :matches, :projects, column: :project_2_id
  end
end
