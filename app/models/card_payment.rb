class CardPayment < ApplicationRecord
  acts_as_paranoid
  belongs_to :card_payable, polymorphic: true, optional: true

  def amount
    super.nil? ? 0 : super
  end
end
