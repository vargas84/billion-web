class AddPointsAndCompetitionToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :points, :integer, null: false
    add_reference :transactions, :competition, null: false, index: true
  end
end
