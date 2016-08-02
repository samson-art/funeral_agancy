class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.integer :kind
      t.attachment :attach
      t.references :order

      t.timestamps null: false
    end
  end
end
