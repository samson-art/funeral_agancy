class CreateAssistants < ActiveRecord::Migration
  def change
    create_table :assistants do |t|
      t.string :name
      t.references :order, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
