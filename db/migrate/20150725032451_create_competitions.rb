class CreateCompetitions < ActiveRecord::Migration
  def change
    create_table :competitions do |t|
      t.string :code_name, default: '', null: false, index: true
      t.date :start_date, null: false, index: true
      t.date :end_date, null: false, index: true

      t.timestamps null: false
    end
  end
end
