class Car < ActiveRecord::Base
  belongs_to :order, touch: true
end
