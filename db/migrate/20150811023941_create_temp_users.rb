class CreateTempUsers < ActiveRecord::Migration
  def change
    create_table :temp_users do |t|
      t.string :email, null: false, index: true

      t.timestamps null: false
    end
  end
end
