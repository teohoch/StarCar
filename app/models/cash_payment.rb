class CashPayment < ApplicationRecord
  belongs_to :cash_payable, polymorphic: true, optional: true
  def amount
    super.nil? ? 0 : super
  end
end
