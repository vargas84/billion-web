class RemoveNullFalseFromTransactions < ActiveRecord::Migration
  def change
    change_column_null :transactions, :amount, true
  end
end
