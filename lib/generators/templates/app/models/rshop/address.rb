class Rshop::Address < ActiveRecord::Base
  self.table_name = 'rshop_addresses'
  belongs_to :addressable, polymorphic: true, touch: true
  attr_accessor :validate_saving

  validates :phone, :address, presence: true, if: :validate_saving

  def validate_saving?
    !!@validate_saving
  end
end
