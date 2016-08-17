class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :deceased
      t.references :relative
      t.integer :status, default: 0

      t.timestamps null: false
    end
  end
end
