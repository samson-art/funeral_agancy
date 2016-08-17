class CreateRelatives < ActiveRecord::Migration
  def change
    create_table :relatives do |t|
      t.string :firstname
      t.string :lastname
      t.string :relationship
      t.string :phone
      t.string :mobile

      t.timestamps null: false
    end
  end
end
