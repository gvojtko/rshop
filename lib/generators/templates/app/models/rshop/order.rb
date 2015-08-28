class Rshop::Order < ActiveRecord::Base
  self.table_name = 'rshop_orders'
  STATUS_IN_BASKET = 1
  STATUS_IN_Q = 2
  STATUS_SOLD = 3
  STATUS_REJECTED = 4

  belongs_to :user, touch: true
  belongs_to :payment, touch: true, class_name: Rshop::Payment, foreign_key: :rshop_payment_id
  belongs_to :delivery, touch: true, class_name: Rshop::Delivery, foreign_key: :rshop_delivery_id
  has_one :address, as: :addressable, dependent: :destroy, class_name: Rshop::Address
  has_many :order_items, dependent: :destroy, class_name: Rshop::OrderItem, foreign_key: :rshop_order_id

  accepts_nested_attributes_for :order_items, allow_destroy: true
  accepts_nested_attributes_for :address

  validates :payment, :delivery, presence: true, if: :validate_saving?

  after_initialize :init

  scope :in_q, -> {where(status: STATUS_IN_Q)}

  def validate_saving val = true
    address.validate_saving = @validate_saving = val
  end

  def validate_saving?
    !!@validate_saving
  end

  def cost
    self.order_items.inject(0) { |sum, oi| sum + oi.cost }
  end

  def has_items?
    self.order_items.count > 0
  end

  def products_count
    self.order_items.inject (0) { |sum, oi| sum + oi.qty }
  end

  def status_title
    Rshop::Order.status_options[self.status]
  end

  def self.status_options
    {
        STATUS_IN_BASKET => I18n.t("rshop.order.status_#{STATUS_IN_BASKET}"),
        STATUS_IN_Q => I18n.t("rshop.order.status_#{STATUS_IN_Q}"),
        STATUS_SOLD => I18n.t("rshop.order.status_#{STATUS_SOLD}"),
        STATUS_REJECTED => I18n.t("rshop.order.status_#{STATUS_REJECTED}"),
    }
  end

  protected

  def init
    self.status ||= STATUS_IN_BASKET
    unless persisted?
      self.address = Rshop::Address.new if self.address.nil?
    end
  end
end
