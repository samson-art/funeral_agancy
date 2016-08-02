class Deceased < ActiveRecord::Base
  has_attached_file :photo, styles: {medium: '300x300>', thumb: '100x100>'}, default_url: '/images/:style/missing.png'
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/

  belongs_to :order

  validates :name, presence: true
  validates :birthday, presence: true
  validates :deathday, presence: true
  validates :funeral_day, presence: true

  enum crematorium_kind: [:camera, :ground, :cremation]

  scope :full, -> {  }
  scope :ordering, -> { order(:funeral_day) }


end
