class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :author, default: '', null: false, index: true
      t.text :content, default: '', null: false, index: true
      t.references :project, null: false

      t.timestamps null: false
    end
  end
end
