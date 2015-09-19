class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.references :competition, index: true
      t.datetime :started_at
      t.datetime :ended_at
      t.datetime :deleted_at

      t.timestamps
    end
    add_foreign_key :rounds, :competitions
  end
end
