class Flower < ActiveRecord::Base
  belongs_to :order, autosave: true

  scope :ordered, -> {  }
  scope :full, -> {  }

end
