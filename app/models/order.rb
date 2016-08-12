class Order < ActiveRecord::Base
  belongs_to :deceased, autosave: true, dependent: :destroy, touch: true
  belongs_to :relative, autosave: true, dependent: :destroy, touch: true
  has_many :flowers, dependent: :destroy
  has_many :assistants, dependent: :destroy
  has_many :cars, dependent: :destroy

  accepts_nested_attributes_for :cars, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :assistants, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :deceased, :update_only => true
  accepts_nested_attributes_for :relative, :update_only => true
  accepts_nested_attributes_for :flowers, reject_if: :all_blank, allow_destroy: true

  validates :relative, presence: true
  validates :deceased, presence: true

  enum :docs_kind => [:check_list, :service_list, :flowers]

  scope :ordered, -> { order(:updated_at).reverse_order }
  scope :full, -> { includes(:deceased, :relative, :flowers, :assistants) }

  def edited_at
    (self[:updated_at] > self[:created_at] ? self[:updated_at] : self[:created_at]).strftime(('%H:%M %d %b, %Y'));
  end

end
