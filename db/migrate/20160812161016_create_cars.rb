class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.string :model
      t.references :order, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
