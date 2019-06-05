class CardPayment < ApplicationRecord
  belongs_to :card_payable, polymorphic: true, optional: true

  def amount
    super.nil? ? 0 : super
  end
end
