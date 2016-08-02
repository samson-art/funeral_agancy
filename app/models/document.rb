class Document < ActiveRecord::Base
  has_attached_file :attach
  validates_attachment_content_type :attach, content_type: ['application/vnd.openxmlformats-officedocument.wordprocessingml.document']

  belongs_to :order

  validates :order, presence: true

  enum :kind => [:check_list, :service_list, :flowers]

  scope :full, -> { includes(:order) }
end
