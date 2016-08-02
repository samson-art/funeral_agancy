class Order < ActiveRecord::Base
  belongs_to :deceased, autosave: true
  belongs_to :relative, autosave: true
  has_many :documents, dependent: :delete_all
  has_many :flowers, dependent: :delete_all

  accepts_nested_attributes_for :deceased
  accepts_nested_attributes_for :relative
  accepts_nested_attributes_for :flowers

  validates :relative, presence: true
  validates :deceased, presence: true

  enum :docs_kind => [:check_list, :service_list, :flowers]

  scope :ordered, -> {  }
  scope :full, -> { includes(:deceased, :relative, :flowers) }

end
