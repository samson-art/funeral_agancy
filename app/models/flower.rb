class Flower < ActiveRecord::Base
  belongs_to :order, touch: true

  scope :ordered, -> {  }
  scope :full, -> {  }

end
