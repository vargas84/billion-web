class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.decimal :amount, precision: 7, scale: 2, null: false, index: true
      t.references :sender, polymorphic: true, index: true
      t.references :recipient, polymorphic: true, null: false, index: true

      t.timestamps null: false
    end
  end
end
