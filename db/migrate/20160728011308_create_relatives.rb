class CreateRelatives < ActiveRecord::Migration
  def change
    create_table :relatives do |t|
      t.string :name
      t.string :relationship
      t.string :phone
      t.string :mobile

      t.timestamps null: false
    end
  end
end
