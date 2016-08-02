class CreateFlowers < ActiveRecord::Migration
  def change
    create_table :flowers do |t|
      t.string  "kind"
      t.integer  "price"
      t.string   "text"
      t.integer  "order_id"

      t.timestamp null: false
    end
  end
end
