class Deceased < ActiveRecord::Base
  has_attached_file :photo, styles: {medium: '300x300>', thumb: '100x100>'}, :default_url => ':style/missing_photo.png'
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/

  belongs_to :order

  validates :name, presence: true
  validates :birthday, presence: true
  validates :deathday, presence: true
  validates :funeral_day, presence: true

  enum crematorium_kind: [:camera, :ground, :cremation]
  enum corpse_kind: ['cadaver', 'remains', 'bones', 'fetus']
  enum vase_issude_by: ['crematorium', 'company']

  scope :full, -> {  }
  scope :ordering, -> { order(:funeral_day) }

  scope :cemetery_names, -> { uniq.pluck(:cemetery_name) }
  scope :funeral_places, -> { uniq.pluck(:funeral_place) }

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

  private
    def set_date(date)
      date.strftime('%d/%m/%Y')
    end

    def set_time(time)
      time.strftime('%H:%M')
    end
end
