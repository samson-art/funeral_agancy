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

  enum :docs_kind => [:check_list, :service_list, :flowers, :cremazione, :epigrafe]
  enum :status => [:active, :archived]

  scope :full, -> { includes(:deceased, :relative, :flowers, :assistants, :cars) }
  scope :part, -> { includes(:deceased, :relative) }

  scope :ordered, -> { order(:updated_at).reverse_order }
  scope :ordered_name, -> { part.order('deceaseds.lastname') }
  scope :ordered_relative, -> { part.order('relatives.lastname') }

  scope :active, -> { where('status=?', 0) }
  scope :archived, -> { where('status=?', 1) }

  def edited_at
    self[:updated_at].strftime(('%H:%M %d %b, %Y'));
  end

  def self.search(query)
    if query
      part.joins(:deceased, :relative).where('deceaseds.firstname like ? or deceaseds.lastname like ? or relatives.firstname like ? or relatives.lastname like ?', "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%")
    else
      part
    end
  end

end
