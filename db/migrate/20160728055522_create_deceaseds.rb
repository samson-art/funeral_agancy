class CreateDeceaseds < ActiveRecord::Migration
  def change
    create_table :deceaseds do |t|
      t.string :name
      t.date :birthday
      t.date :deathday
      t.date :funeral_day
      t.time :funeral_time
      t.string :funeral_place
      t.string :cemetery_name
      t.string :coffin_kind
      t.integer :crematorium_kind
      t.attachment :photo
      t.string :coffin_prepare_by
      t.string :coffin_issued_by
      t.string :note
      t.date :flowerday
      t.time :flowertime

      t.timestamps null: false
    end
  end
end
