class Deceased < ActiveRecord::Base
  has_attached_file :photo, styles: {medium: '300x300>', thumb: '100x100>'}, :default_url => ':style/missing_photo.png'
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/

  belongs_to :order, touch: true

  validates :name, presence: true
  validates :birthday, presence: true
  validates :deathday, presence: true
  validates :funeral_day, presence: true

  enum crematorium_kind: [:camera, :ground, :cremation]
  enum corpse_kind: [:cadaver, :remains, :bones, :fetus]
  enum vase_issude_by: [:crematorium, :company]

  scope :full, -> {  }
  scope :ordering, -> { order(:funeral_day) }

  scope :cemetery_names, -> { uniq.pluck(:cemetery_name) }
  scope :funeral_places, -> { uniq.pluck(:funeral_place) }
  scope :coffin_kinds, -> { uniq.pluck(:coffin_kind) }

  def age
    (self[:deathday].year-self[:birthday].year)- (self[:birthday].to_date.change(:year => self[:deathday].year) > self[:deathday] ? 1 : 0)
  end

  def name
    "#{self[:firstname]} #{self[:lastname]}"
  end

  def funeral_day
    set_date(self[:funeral_day])
  end

  def funeral_time
    set_time(self[:funeral_time])
  end

  def birthday
    set_date(self[:birthday])
  end

  def deathday
    set_date(self[:deathday])
  end

  def exposure_day
    set_date(self[:exposure_day])
  end

  def morgue_work_from
    set_time(self[:morgue_work_from])
  end

  def morgue_work_to
    set_time(self[:morgue_work_to])
  end

  def flowerday
    set_date(self[:flowerday])
  end

  def flowertime
    set_time(self[:flowertime])
  end

  def departure_day
    set_date(self[:departure_day])
  end

  def departure_time
    set_time(self[:departure_time])
  end

  private
    def set_date(date)
      if date.present?
        date.strftime('%d/%m/%Y')
      end
    end

    def set_time(time)
      if time.present?
        time.strftime('%H:%M')
      end
    end
end
