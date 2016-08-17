class CreateDeceaseds < ActiveRecord::Migration
  def change
    create_table :deceaseds do |t|
      t.string :firstname
      t.string :lastname
      t.date :birthday
      t.date :deathday
      t.string :born_place
      t.string :registered_in
      t.string :registered_in_street
      t.string :death_place
      t.integer :corpse_kind
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
      t.boolean :pillow_take
      t.boolean :instruments_1, default: false
      t.boolean :instruments_2, default: false
      t.boolean :instruments_3, default: false
      t.boolean :instruments_4, default: false
      t.boolean :information_1, default: false
      t.boolean :information_2, default: false
      t.boolean :cemetery_1, default: false
      t.boolean :cemetery_2, default: false

      t.date :arrive_day
      t.time :arrive_time
      t.string :arrive_from

      t.integer :vase_issued_by

      t.string :invoice_company
      t.string :invoice_place
      t.string :invoice_street
      t.string :invoice_house

      t.date :exposure_day

      t.time :morgue_work_from
      t.time :morgue_work_to

      t.date :departure_day
      t.time :departure_time

      t.timestamps null: false
    end
  end
end
