class Relative < ActiveRecord::Base
  has_many :deceaseds, through: :orders

  scope :full, -> { }
  scope :ordered, -> { }
  scope :relationships, -> { uniq.pluck(:relationship) }
end
