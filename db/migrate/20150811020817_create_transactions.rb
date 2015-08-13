class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :amount, default: 0, null: false, index: true
      t.references :sender, polymorphic: true, null: false, index: true
      t.references :recipient, polymorphic: true, null: false, index: true

      t.timestamps null: false
    end
  end
end
